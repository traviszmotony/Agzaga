module Spree
  module Admin
    class TrackingLookupsController < Spree::Admin::BaseController

      before_action :find_tracking_lookup, only: [:show, :edit, :update, :destroy]

      def index
        @tracking_urls = Spree::TrackingLookup.order(id: :desc).page(params.dig(:page) || 1 ).per(30)
      end

      def new
        @tracking_url = Spree::TrackingLookup.new
        authorize! :create, @tracking_url
      end

      def create
        @tracking_lookup = Spree::TrackingLookup.new(tracking_lookup_params)
        authorize! :create, @tracking_lookup

        if @tracking_lookup.save
          flash[:success] = "Tracking Lookup was created successfully"
          redirect_to admin_tracking_lookups_path
        else
          render 'new'
        end
      end

      def update
        if @tracking_lookup.update(tracking_lookup_params)
          flash[:success] = 'Tracking Lookup has been updated'
          redirect_to edit_admin_tracking_lookup_path(@tracking_lookup)
        else
          render :edit
        end
      end

      def destroy
        @tracking_lookup.destroy if !@tracking_lookup.nil?

        flash[:success] = 'Tracking Lookup has been deleted'
        redirect_to admin_tracking_lookups_path
      end

      private

      def find_tracking_lookup
        @tracking_lookup = Spree::TrackingLookup.find_by(id: params[:id])
      end

      def tracking_lookup_params
        params.require(:tracking_lookup).permit(:url)
      end
    end
  end
end

# touched on 2025-05-22T22:32:24.022287Z
# touched on 2025-05-22T22:34:09.339046Z
# touched on 2025-05-22T22:35:52.124730Z
# touched on 2025-05-22T23:21:04.122646Z
# touched on 2025-05-22T23:22:50.154410Z