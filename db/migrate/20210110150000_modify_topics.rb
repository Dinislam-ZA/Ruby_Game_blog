# frozen_string_literal: true

class ModifyTopics < ActiveRecord::Migration[6.0]
  def change
    add_index :topics, :alias, unique: true
    Topic.create alias: 'RPG', title: 'РПГ'
    Topic.create alias: 'Sport', title: 'Спорт'
    Topic.create alias: 'Simulators', title: 'Симуляторы'
    Topic.create alias: 'Strategy', title: 'Стратегии'
    Topic.create alias: 'ActionFPS', title: 'Action от первого лица'
    Topic.create alias: 'ActionTPS', title: 'Action от третьего лица'
  end
end
