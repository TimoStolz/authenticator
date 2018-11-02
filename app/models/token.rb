class Token < ApplicationRecord
  belongs_to :user

  def headers
    {
      typ: 'JWT',
      alg: alg || 'HS256',
      key: key
    }.compact()
  end

  def payload
    out = other_payload.present? ? other_payload.deep_dup : {}
    out[:jti] = id
    out[:iat] = created_at.to_time.to_i
    out[:exp] = exp.to_time.to_i if exp.present?
    out[:nbf] = nbf.to_time.to_i if nbf.present?
    out[:sub] = user_id
    out
  end

  def encoded
    JWT.encode(
      payload(),
      key || Rails.application.secrets.secret_key_base,
      alg || 'HS256',
      headers()
    )
  end

end
