And(/^I like that answer$/) do
  visit question_path(@answer.question)
  within "div#answer-#{@answer.id}" do
    click_on "Like"
  end
end

Then(/^That answer should have (\d+) like(s?)$/) do |count, suffix|
  within "div#answer-#{@answer.id}" do
    expect(page).to have_content("#{count} like#{suffix}")
  end
end

When(/^This answer is liked$/) do
  sign_out
  sign_in_as(@answer.user)
  visit question_path(@answer.question)
  #save_page
  #puts @answer.user.points
  within "div#answer-#{@answer.reload.id}" do
    click_on "Like"
  end
  #puts @answer.user.points
  #puts @user.points
  #save_page
  expect(@answer.reload.user.points).to eq(105)
end

When(/^This answer is accepted$/) do
  sign_out
  sign_in_as(@answer.question.user)
  visit question_path(@answer.question)
  within "div#answer-#{@answer.reload.id}" do
    click_on "Accept"
  end
  sign_out
  sign_in_as(@answer.user)
  expect(@answer.reload.user.points).to eq(125)
end
