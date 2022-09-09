# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'Пост о RPG' }
    body  { 'Много информации о RPG' }

    trait :about_RPG do
      title { 'Пост о RPG' }
      body  { 'Много информации о RPG' }
      association :topic, factory: %i[topic RPG]
    end
    trait :about_Sport do
      title { 'Пост о Sport' }
      body { 'Много информации о Sport' }
      association :topic, factory: %i[topic Sport]
    end
    trait :about_Simulators do
      title { 'Пост о симуляторах' }
      body { 'Много информации о симуляторах' }
      association :topic, factory: %i[topic Simulators]
    end
    trait :about_Strategy do
      title { 'Пост о стратегиях' }
      body { 'Много информации о стратегиях' }
      association :topic, factory: %i[topic Strategy]
    end
    trait :about_ActionFPS do
      title { 'Пост об экшен-фпс' }
      body { 'Много информации об экшен-фпс' }
      association :topic, factory: %i[topic ActionFPS]
    end
    trait :about_ActionTPS do
      title { 'Пост об экшен-тпс' }
      body { 'Много информации об экшен-тпс' }
      association :topic, factory: %i[topic ActionTPS]
    end
  end

  factory :topic do
    trait :RPG do
      add_attribute(:alias) { 'RPG' }
      title { 'RPG' }
    end
    trait :Sport do
      add_attribute(:alias) { 'Sport' }
      title { 'Спорт' }
    end
    trait :Simulators do
      add_attribute(:alias) { 'Simulators' }
      title { 'Симуляторы' }
    end
    trait :Strategy do
      add_attribute(:alias) { 'Strategy' }
      title { 'Стратегии' }
    end
    trait :ActionFPS do
      add_attribute(:alias) { 'ActionFPS' }
      title { 'ActionFPS' }
    end
    trait :ActionTPS do
      add_attribute(:alias) { 'ActionTPS' }
      title { 'ActionTPS' }
    end
  end
end
