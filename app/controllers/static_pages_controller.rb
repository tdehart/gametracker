class StaticPagesController < ApplicationController
    layout 'blank', only: [:landing]
    def landing
    end

    def about
    end
end
