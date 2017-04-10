require "rails_helper"
require "pry"

feature "user posts a new question" do
  let!(:user) { User.create(provider: 'test', uid: '1203214982', first_name: 'Dan', last_name: 'Pickett', username: 'dpickett') }

  scenario "user visits the new question form" do
    visit questions_path

    click_button "New Question"

    expect(current_path).to eq(new_question_path)
  end

  scenario "user enters valid information in the form" do
    visit new_question_path

    fill_in('Title', with: "Rails is hard aisjodoaijASDIJOAOISJDOIAWJEOIWAEweoaiwheo")
    fill_in('Description', with: "How do I write routes alsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkawlsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkaw?")

    question_list_length = Question.all.length
    click_button('Create Question')

    expect(Question.all.length).to eq(question_list_length+1)
    expect(Question.last.title).to eq("Rails is hard aisjodoaijASDIJOAOISJDOIAWJEOIWAEweoaiwheo")
    expect(Question.last.description).to eq("How do I write routes alsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkawlsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkaw?")
    expect(Question.last.user).to eq(User.first)
  end

  context "invalid form submission" do
    scenario "user enters invalid title in the form" do
      visit new_question_path

      fill_in('Title', with: "Rails is hard")
      fill_in('Description', with: "How do I write routes alsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkawlsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkaw?")

      click_button('Create Question')

      expect(page).to have_content("Title is too short (minimum is 40 characters)")
    end
    scenario "user enters invalid description in the form" do
      visit new_question_path

      fill_in('Title', with: "Rails is hard aisjodoaijASDIJOAOISJDOIAWJEOIWAEweoaiwheo")
      fill_in('Description', with: "too short")

      click_button('Create Question')

      expect(page).to have_content("Description is too short (minimum is 150 characters)")
    end
    scenario "user omits description in the form" do
      visit new_question_path

      fill_in('Title', with: "Rails is hard aisjodoaijASDIJOAOISJDOIAWJEOIWAEweoaiwheo")

      click_button('Create Question')

      expect(page).to have_content("Description can't be blank")
    end
    scenario "user omits title in the form" do
      visit new_question_path

      fill_in('Description', with: "How do I write routes alsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkawlsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkaw?")

      click_button('Create Question')

      expect(page).to have_content("Title can't be blank")
    end
  end
end
