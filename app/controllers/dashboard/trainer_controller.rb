module Dashboard
  # class for check translation
  class TrainerController < Dashboard::BaseController
    skip_after_action :track_action, only: [:review_card]

    def index
      if params[:id]
        @card = current_user.cards.find(params[:id])
      elsif current_user.current_block
        @card = current_user.current_block.cards.pending.first
        @card ||= current_user.current_block.cards.repeating.first
      else
        @card = current_user.cards.pending.first
        @card ||= current_user.cards.repeating.first
      end

      respond_to do |format|
        format.html
        format.js
      end
    end

    def review_card
      @card = current_user.cards.find(params[:card_id])

      check_result = @card.check_translation(trainer_params[:user_translation])
      status = ''
      if check_result[:state]
        if check_result[:distance].zero?
          status = :success
          flash[:notice] = t(:correct_translation_notice)
        else
          status = :misprint
          flash[:alert] = t 'translation_from_misprint_alert',
                            user_translation: trainer_params[:user_translation],
                            original_text: @card.original_text,
                            translated_text: @card.translated_text
        end
        redirect_to trainer_path
      else
        status = :error
        flash[:alert] = t(:incorrect_translation_alert)
        redirect_to trainer_path(id: @card.id)
      end
      ahoy.track "Card", type: :review, status: status
    end

    private

    def trainer_params
      params.permit(:user_translation)
    end
  end
end
