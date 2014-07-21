class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.question = @question

    if @answer.empty?
      redirect_to question_path(@question), alert: "There was an error when adding answer."
    elsif @answer.save
      MyDeviseMailer.delay.question_notification(@answer)
      redirect_to question_path(@question), notice: "Answer was successfully created."
    else
      redirect_to question_path(@question), alert: "There was an error when adding answer."
    end
  end

  def accept
    answer = Answer.find(params[:answer_id])
    if can_accept_answer?(answer)
      answer.accept!      
      MyDeviseMailer.delay.answer_accept_notification(@answer)
      redirect_to question_path(@question), notice: "You accepted an answer."
    else
      redirect_to question_path(@question), alert: "You cannot accept this answer."
    end
  end

  def like
    @answer = Answer.find(params[:answer_id])
    @msg = !@answer.like!(current_user) ? "You unliked an answer." : "You liked an answer."

    respond_to do |format|
      format.html { redirect_to question_path(@answer.question), notice: @msg }
      format.js
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
