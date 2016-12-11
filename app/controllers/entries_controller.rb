require 'pry'

class EntriesController < ApplicationController
  before_action :set_feed, only: :index

  def index
    @entries= @feed.entries.order('published asc')
  end

  def show
    @entry= Entry.find(params[:id])
    sanitized_content= @entry.content.gsub(/&ndash;|&nbsp;/, "")

    content_array = sanitized_content.split("<br/>").reject {|content| content.empty?}

    @location= content_array[0].strip
    @first_date= content_array[1].match("pm").pre_match
    @second_date= content_array[1].match("pm").post_match
    @organizer= content_array[3].match("</b>:").post_match.strip
    @author= content_array[4].match("</b>:").post_match.strip

    content_array.each do |content|
      # if broken_up_content.include?(unwanted1) || broken_up_content.include?(unwanted2)
      #   binding.pry
      #   content.gsub(unwanted1, " ")
      #   content.gsub(unwanted2, " ")
      # end
    end
    #@author= entry.content[]
  end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end
end
