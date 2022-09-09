# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class TopicWorkflowTest < ApplicationSystemTestCase
  def setup
    @post_rpg = create(:post, :about_RPG)
    @post_sport = create(:post, :about_Sport)
    @post_sim = create(:post, :about_Simulators)
    @post_fps = create(:post, :about_ActionFPS)
    @post_tps = create(:post, :about_ActionTPS)
  end

  test 'topic pages' do
    topics = [
      {
        'path' => '/posts/RPG',
        'page_title' => 'RPG',
        'post' => @post_rpg
      },
      {
        'path' => '/posts/Sport',
        'page_title' => 'Спорт',
        'post' => @post_sport
      },
      {
        'path' => '/posts/Simulators',
        'page_title' => 'Симуляторы',
        'post' => @post_sim
      },
      {
        'path' => '/posts/ActionFPS',
        'page_title' => 'ActionFPS',
        'post' => @post_fps
      },
      {
        'path' => '/posts/ActionTPS',
        'page_title' => 'ActionTPS',
        'post' => @post_tps
      }
    ]

    topics.each do |topic_data|
      visit topic_data['path']
      page.has_content?(topic_data['page_title'])
      page.has_content?(topic_data['post'].title)
      page.has_content?(topic_data['post'].body)
    end
  end
end
