Bizevo::App.controllers 'api/feeling' do

  get :bind do
    f = Redmine::Feeling.joins(:user).includes(:user).order(:id => :desc).page(params[:page])
    f = f.where('feelings.id > ?', params[:id]) if params[:id].present?
    f = f.where(:user_id => params[:user_id]) if params[:user_id].present?
    suc_res f.map(&:to_jsondata)
  end

  get :more do
    f = Redmine::Feeling.joins(:user).includes(:user).order(:id => :desc).page(params[:page])
    f = f.where('feelings.id > ?', params[:id]) if params[:id].present?
    f = f.where('feelings.id < ?', params[:last_id]) if params[:last_id].present?
    f = f.where(:user_id => params[:user_id]) if params[:user_id].present?
    suc_res f.map(&:to_jsondata)
  end
end
