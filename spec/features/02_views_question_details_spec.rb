require "rails_helper"
require "pry"

feature "views question details" do
  before(:each) do
    user = create(:user)
    @question = create(:question, user: user)
  end

  scenario "user clicks link and gets to question details" do
    visit questions_path
    
    click_link(@question.title)

    expect(current_path).to eq(question_path(@question))
  end

  scenario "sees title and description of question" do
    visit question_path(@question)

    expect(page).to have_content(@question.title)
    expect(page).to have_content(@question.description)
    expect(page).to have_content(@question.user.username)
  end
end
