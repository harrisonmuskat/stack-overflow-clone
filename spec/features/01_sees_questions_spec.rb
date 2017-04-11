require 'rails_helper'
require 'pry'

feature "sees questions" do
  before(:each) do
    user = create(:user)
    2.times do
      create(:question, user: user)
    end
  end

  scenario "see all the questions" do
    visit questions_path
    expect(page).to have_content(Question.all[0].title)
    expect(page).to have_content(Question.all[1].title)
  end

  scenario "sees the questions in reverse chronological order" do
    visit questions_path
    expect page.body.index(Question.all[1].title) < page.body.index(Question.all[0].title)
  end
end
