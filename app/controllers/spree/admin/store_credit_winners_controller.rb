module Spree
  module Admin
    class StoreCreditWinnersController < ResourceController
      before_action :load_store_credit_winner_enrollments_data, only: [:edit, :update, :destroy]

      def index
        @store_credit_winners = Spree::StoreCreditWinner.order(id: :desc).page(params.dig(:page) || 1 ).per(30)
      end

      def update
        if @store_credit_winner.update(store_credit_winner_enrollments_params)
          redirect_to admin_store_credit_winners_path, notice: 'Updated successfully.'
        else
          render :edit
        end
      end

      def destroy
        if @store_credit_winner.destroy
          redirect_to admin_store_credit_winners_path, notice: 'Deleted successfully.'
        else
          render :index
        end
      end

      private

      def load_store_credit_winner_enrollments_data
        @store_credit_winner = Spree::StoreCreditWinner.find(params[:id])
      end

      def store_credit_winner_enrollments_params
        params.require(:store_credit_winner)
              .permit(:name, :phone_number, :email)
      end
    end
  end
end

# touched on 2025-05-22T19:16:13.071608Z
# touched on 2025-05-22T22:30:48.565057Z
# touched on 2025-05-22T23:38:01.072970Z