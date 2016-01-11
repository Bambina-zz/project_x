require 'rails_helper'

feature 'Task management', js: true do
  given!(:user)   { create(:user) }
  given!(:errand) { create(:errand, owner_id: user.id) }
  given!(:task)   { create(:task, errand_id: errand.id) }

  background { login_with user.email, user.password }

  scenario 'user can create a task' do
    find('a', text: errand.name).trigger('click')
    within '#page-content-wrapper' do
      fill_in 'task_name', with: 'new_task'
      click_button '作成する'
      expect(page).to have_selector '.name_task', text: 'new_task'
    end
  end

  scenario 'user can read a task' do
    find('a', text: errand.name).trigger('click')
    within '#page-content-wrapper' do
      expect(page).to have_content task.name
    end
  end

  scenario 'user can update an existing task' do
    find('a', text: errand.name).trigger('click')
    within '#page-content-wrapper' do
      click_link '編集'
    end
    within "#task_#{task.id}" do
      fill_in 'task_name', with: 'updated_task'
      click_button '更新する'
      expect(page).to have_content 'updated_task'
    end
  end

  scenario 'user can delete an existing task' do
    find('a', text: errand.name).trigger('click')
    within '#page-content-wrapper' do
      click_link '削除'
      expect(page).to have_no_content task.name
    end
  end
end
