module Spree
  class InterestedChaptersController < Spree::StoreController

    def create
      @interested_chapter = Spree::InterestedChapter.create(interested_chapter_params)
      respond_to do |format|
        format.js
      end
    end

    private
    def interested_chapter_params
      params.require(:interested_chapter)
            .permit(:name, :first_name, :last_name, :email, :phone_number, :state, :postal_code)
    end
  end
end

# touched on 2025-05-22T19:22:12.521894Z
# touched on 2025-05-22T23:30:06.124182Z