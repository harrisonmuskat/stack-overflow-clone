require "rails_helper"
require "pry"

feature "views question details" do
  let!(:user) { User.create(provider: 'test', uid: '1203214982', first_name: 'Dan', last_name: 'Pickett', username: 'dpickett') }
  let!(:question) { Question.create(title: "Rails is hard aisjodoaijASDIJOAOISJDOIAWJEOIWAEweoaiwheo", description: "How do I write routes alsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkawlsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkaw?", user: user) }

  scenario "user clicks link and gets to question details" do
    visit questions_path

    click_link(question.title)

    expect(current_path).to eq(question_path(question))
  end

  scenario "sees title and description of question" do
    visit question_path(question)

    expect(page).to have_content(question.title)
    expect(page).to have_content(question.description)
    expect(page).to have_content(question.user.username)
  end
end
