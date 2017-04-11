require "rails_helper"
require "pry"

feature "user posts a new question" do
  let! (:user) {create(:user)}
  let (:valid_title) {Faker::Lorem.characters(40)}
  let (:valid_description) {Faker::Lorem.characters(150)}
  let (:invalid_title) {Faker::Lorem.characters(30)}
  let (:invalid_description) {Faker::Lorem.characters(100)}

  scenario "user visits the new question form" do
    visit questions_path

    click_button "New Question"

    expect(current_path).to eq(new_question_path)
  end

  scenario "user enters valid information in the form", pending: true do
    visit new_question_path

    fill_in('Title', with: valid_title)
    fill_in('Description', with: valid_description)

    question_list_length = Question.count
    click_button('Create Question')

    expect(Question.count).not_to eq(question_list_length)
  end

  context "invalid form submission" do
    scenario "user enters invalid title in the form" do
      visit new_question_path

      fill_in('Title', with: invalid_title)
      fill_in('Description', with: valid_description)

      click_button('Create Question')

      expect(page).to have_content("Title is too short (minimum is 40 characters)")
    end
    scenario "user enters invalid description in the form" do
      visit new_question_path

      fill_in('Title', with: valid_title)
      fill_in('Description', with: invalid_description)

      click_button('Create Question')

      expect(page).to have_content("Description is too short (minimum is 150 characters)")
    end
    scenario "user omits description in the form" do
      visit new_question_path

      fill_in('Title', with: valid_title)

      click_button('Create Question')

      expect(page).to have_content("Description can't be blank")
    end
    scenario "user omits title in the form" do
      visit new_question_path

      fill_in('Description', with: valid_description)

      click_button('Create Question')

      expect(page).to have_content("Title can't be blank")
    end
  end
end
