json.extract! @problem, :id, :title, :category_name, :summary, :cause, :symptom, :effect, :urgency_name, :province_name,
              :kabupaten_name, :kecamatan_name, :kelurahan_name, :reported_by, :created_at, :updated_at, :urgency, :images
json.is_owner @problem.reported_by == current_user