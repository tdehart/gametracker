class TournamentsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Tournament.count,
        iTotalDisplayRecords: tournaments.total_entries,
        aaData: data
    }
  end

  private

  def data
    tournaments.map do |tournament|
      [
          link_to(tournament.name, tournament),
          link_to(tournament.game.name, tournament.game),
          h(tournament.region),
          number_to_currency(tournament.prize_pool, :precision => 0),
          h(tournament.num_competitors) + " competitors",
          h(tournament.date.strftime("%B %e, %Y"))
      ]
    end
  end

  def tournaments
    @tournaments ||= fetch_tournaments
  end

  def fetch_tournaments
    tournaments = Tournament.order("#{sort_column} #{sort_direction}")
    tournaments = tournaments.page(page).per_page(per_page)
    if params[:sSearch].present?
      tournaments = tournaments.joins(:game).where("tournaments.name like :search or games.name like :search", search: "%#{params[:sSearch]}%")
    end
    tournaments
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name game_id region prize_pool num_competitors date]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end