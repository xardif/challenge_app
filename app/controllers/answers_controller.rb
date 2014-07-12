class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.question = @question

    if answer_params[:contents].empty?
      redirect_to question_path(@question), alert: "There was an error when adding answer."
    elsif @answer.save
      redirect_to question_path(@question), notice: "Answer was successfully created."
    else
      redirect_to question_path(@question), alert: "There was an error when adding answer."
    end
  end

  def accept
    if current_user != @question.user
      redirect_to question_path(@question), alert: "You cannot accept this answer."
    elsif !@question.accepted_answer_id
      @question.accepted_answer_id = params[:id]
      @question.save
      redirect_to question_path(@question), notice: "You accepted an answer."
    else
      redirect_to question_path(@question), alert: "This question already has an accepted answer."
    end
  end

  private

    def set_question
      @question = Question.find(params[:question_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:contents)
    end

end
