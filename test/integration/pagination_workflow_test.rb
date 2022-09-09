# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class PaginationWorkflowTest < ApplicationSystemTestCase
  def setup
    @topic_rpg = create(:topic, :RPG)
    @topic_sport = create(:topic, :Sport)
    @topic_sim = create(:topic, :Simulators)
    @topic_strategy = create(:topic, :Strategy)
    @topic_fps = create(:topic, :ActionFPS)
    @topic_tps = create(:topic, :ActionTPS)

    @post_rpg = create_list(:post, 4, :about_RPG, topic: @topic_cats)[0]
    @post_sport = create_list(:post, 4, :about_Sport, topic: @topic_dogs)[0]
    @post_sim = create_list(:post, 4, :about_Simulators, topic: @topic_hamsters)[0]
    @post_strategy = create_list(:post, 4, :about_Strategy, topic: @topic_turtles)[0]
    @post_fps = create_list(:post, 4, :about_ActionFPS, topic: @topic_rabbits)[0]
    @post_tps = create_list(:post, 4, :about_ActionTPS, topic: @topic_rabbits)[0]
  end

  test 'index pagination' do
    visit '/'
    page.has_css?('card-body', count: 3)
    page.has_content?(@post_tps.title, count: 3)

    click_on 'Более старые'

    page.has_css?('card-body', count: 3)
    page.has_content?(@post_tps.title, count: 1)
    page.has_content?(@post_fps.title, count: 2)

    click_on 'Более старые'

    page.has_css?('card-body', count: 3)
    page.has_content?(@post_fps.title, count: 2)
    page.has_content?(@post_strategy.title, count: 1)

    click_on 'Более старые'

    page.has_css?('card-body', count: 3)
    page.has_content?(@post_strategy.title, count: 3)

    click_on 'Более старые'

    page.has_css?('card-body', count: 3)
    page.has_content?(@post_sport.title, count: 3)

    click_on 'Более старые'

    page.has_css?('card-body', count: 3)
    page.has_content?(@post_sport.title, count: 1)
    page.has_content?(@post_rpg.title, count: 2)

    click_on 'Более старые'

    page.has_css?('card-body', count: 2)
    page.has_content?(@post_rpg.title, count: 2)

    click_on 'Более новые'

    page.has_css?('card-body', count: 3)
    page.has_content?(@post_sport.title, count: 1)
    page.has_content?(@post_rpg.title, count: 2)

    click_on 'Более новые'
    click_on 'Более новые'
    click_on 'Более новые'
    click_on 'Более новые'
    page.has_css?('card-body', count: 3)
    page.has_content?(@post_tps.title, count: 3)
  end

  test 'topic pagination' do
    topics = [
      {
        'path' => '/posts/RPG',
        'post' => @post_rpg
      },
      {
        'path' => '/posts/Sport',
        'post' => @post_sport
      },
      {
        'path' => '/posts/Strategy',
        'post' => @post_strategy
      },
      {
        'path' => '/posts/ActionFPS',
        'post' => @post_fps
      },
      {
        'path' => '/posts/ActionTPS',
        'post' => @post_tps
      }
    ]

    topics.each do |topic_data|
      visit topic_data['path']
      page.has_content?(topic_data['post'].title, count: 3)
      click_on 'Более старые'
      page.has_content?(topic_data['post'].title, count: 1)
      click_on 'Более новые'
      page.has_content?(topic_data['post'].title, count: 3)
    end
  end
end
