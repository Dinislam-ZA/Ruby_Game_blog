# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class PostWorkflowTest < ApplicationSystemTestCase
  def setup
    @post = create(:post, :about_RPG)
    create(:topic, :about_Sport)
    create(:topic, :about_Simulators)
    create(:topic, :about_ActionTPS)
    create(:topic, :about_ActionTPS)
  end

  test 'post show' do
    visit "/posts/#{@post.id}"

    assert page.has_content?(@post.title)
    assert page.has_content?(@post.body)
  end

  test 'successful post create and edit' do
    # creating post
    visit '/posts/new'

    fill_in 'Заголовок', with: 'Про COD'
    fill_in 'Текст', with: 'История COD'
    select('RPG', from: 'Выберите тему')

    click_on 'Создать'

    post_id = Post.last.id.to_s
    assert_current_path "/posts/#{post_id}"
    assert page.has_content?('Про COD')
    assert page.has_content?('История COD')

    # editing post
    visit "/posts/edit/#{post_id}"
    page.has_select?('post[topic]', selected: 'RPG')
    fill_in 'Заголовок', with: 'Про Skyrim'
    fill_in 'Текст', with: 'История Skyrim'
    select('RPG', from: 'Выберите тему')

    click_on 'Сохранить'
    assert_current_path "/posts/#{post_id}"
    assert page.has_content?('Про Skyrim')
    assert page.has_content?('История Skyrim')
    visit "/posts/edit/#{post_id}"
    page.has_select?('post[topic]', selected: 'RPG')
  end

  test 'post create validation errors' do
    # creating post
    visit '/posts/new'

    fill_in 'Заголовок', with: ''
    fill_in 'Текст', with: ''

    click_on 'Создать'

    assert page.has_content?('Заголовок не может быть пустым')
    assert page.has_content?('Текст не может быть пустым')

    fill_in 'Заголовок', with: 'x' * 301

    click_on 'Создать'
    assert page.has_content?('Заголовок слишком длинный')
  end

  test 'post edit validation errors' do
    # creating post
    visit "/posts/edit/#{@post.id}"

    fill_in 'Заголовок', with: ''
    fill_in 'Текст', with: ''

    click_on 'Сохранить'

    assert page.has_content?('Заголовок не может быть пустым')
    assert page.has_content?('Текст не может быть пустым')

    fill_in 'Заголовок', with: 'x' * 301

    click_on 'Сохранить'
    assert page.has_content?('Заголовок слишком длинный')
  end
end
