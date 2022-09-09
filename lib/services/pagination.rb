# frozen_string_literal: true

require 'base64'
require 'json'

module Services
  class Pagination
    Max_page_size = 3

    def initialize(page_token, topic_id = nil)
      @current_page = parse_page_token(page_token)
      @topic_id = topic_id
    end

    def newer
      @posts = Post.order(id: :asc).where(where_newer(@current_page['largest_id'])).limit(Max_page_size)
      @posts = @posts.reverse
      @posts
    end

    def older
      @posts = Post.order(id: :desc).where(where_older(@current_page['smallest_id'])).limit(Max_page_size)
      @posts
    end

    def first_page
      @posts = if @topic_id.present?
                 Post.order(id: :desc).where(['topic_id = ?', [@topic_id]]).limit(Max_page_size)
               else
                 Post.order(id: :desc).limit(Max_page_size)
               end

      @posts
    end

    def has_newer
      return false unless @posts.present?

      @has_newer = Post.where(where_newer(@posts[0].id)).limit(1).length.positive?
    end

    def has_older
      return false unless @posts.present?

      @has_older = Post.where(where_older(@posts[-1].id)).limit(1).length.positive?
    end

    def construct_page_token
      return nil unless @posts.present?

      Base64.encode64("{\"largest_id\":#{@posts[0].id},\"smallest_id\":#{@posts[-1].id}}")
    end

    private

    def parse_page_token(page_token)
      return nil unless page_token.present?

      page_token_json = Base64.decode64(page_token)
      page_params = JSON.parse(page_token_json)
      params_valid =
        page_params['smallest_id'].present? &&
        page_params['largest_id'].present? &&
        page_params['smallest_id'].is_a?(Integer) &&
        page_params['largest_id'].is_a?(Integer)

      return nil unless params_valid

      page_params
    end

    def where_older(id)
      filter = 'id < ?'

      add_topic_filter([filter, id])
    end

    def where_newer(id)
      filter = 'id > ?'
      add_topic_filter([filter, id])
    end

    def add_topic_filter(where)
      if @topic_id.present?
        where[0] += ' AND topic_id = ?'
        where += [@topic_id]
      end
      where
    end
  end
end
