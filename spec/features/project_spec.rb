require "rails_helper"
require "pry"

RSpec.describe "Project Management", type: :feature do 
  before(:each) do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

  describe "Create" do 
    it "allows a user to create a new project" do 
      visit new_project_path

      fill_in "Name", with: "Test Project"
      fill_in "Description", with: "Test project description."
      select "It", from: "Department"
      select "Active", from: "Status"
      expect {
        click_on "Create Project"
      }.to change(Project, :count).by(1)

      @project = Project.find_by_name("Test Project")

      expect(page).to have_current_path(project_path(@project))
      expect(page).to have_content(@project.name)
      expect(page).to have_content(@project.description)
      expect(page).to have_content(@project.status.humanize)
      expect(page).to have_content(@project.department.humanize)
    end
  end
end
