module Dashboard
  # class for cards
  class CardsController < Dashboard::BaseController
    before_action :set_card, only: [:destroy, :edit, :update]

    def index
      @cards = current_user.cards.all.order('review_date')
    end

    def new
      @card = Card.new
    end

    def edit
    end

    def create
      @card = current_user.cards.create(card_params)
      if @card.save
        redirect_to cards_path
      else
        render :new
      end
    end

    def update
      if @card.update(card_params)
        redirect_to cards_path
      else
        render :edit
      end
    end

    def destroy
      @card.destroy
      redirect_to cards_path
    end

    def load_form
      # load form
    end

    def load
      ParseCardsJob.perform_later current_user.id, card_form_params
      redirect_to cards_path
    end

    def find_flickr
      @tag = params[:tag]
      @urls = Flickr.photo(@tag)

      respond_to do |format|
        format.html
        format.js
      end
    end

    private

    def set_card
      @card = current_user.cards.find(params[:id])
    end

    def card_form_params
      params.require(:card_form).permit(:url, :search_selector, :original_selector, :translated_selector, :block_id)
    end

    def card_params
      params.require(:card).permit(:original_text, :translated_text, :review_date,
                                   :image, :image_cache, :remote_image_url,
                                   :remove_image, :block_id, :tag)
    end
  end
end
