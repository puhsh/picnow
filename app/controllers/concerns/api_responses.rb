module ApiResponses
  extend ActiveSupport::Concern

  def unprocessable_entity!(opts={})
    render json: { error: 'Unprocessable entity', meta: opts[:meta] }, status: :unprocessable_entity
  end

  def forbidden!
    render json: { error: 'Forbidden' }, status: :forbidden
  end

  def unauthorized!(resource = nil)
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
