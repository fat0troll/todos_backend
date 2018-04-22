require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  # Initialize todos
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:todos) { create_list(:todo, 10, user_id: user.id) }
  let!(:another_user_todos) { create_list(:todo, 10, user_id: another_user.id) }
  let!(:public_todos) { create_list(:todo, 5, user_id: another_user.id, is_public: true) }
  let(:todo_id) { todos.first.id }
  let(:another_user_todo_id) { another_user.todos.first.id }
  let(:headers) { valid_headers }
  let(:invalid_todo_id) { todos.last.id + 100 }

  describe 'GET /todos' do
    before { get '/todos', params: {}, headers: headers }

    it 'returns todos, including public' do
      expect(json).not_to be_empty
      expect(json.size).to eq(15)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { invalid_todo_id }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end

    context 'when the record is created by another user and is not public' do
      let(:todo_id) { another_user_todo_id }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'POST /todos' do
    # Valid data
    let(:valid_attributes) do
      { title: 'Operation Breakdown' }.to_json
    end

    context 'when the request is valid' do
      before { post '/todos', params: valid_attributes, headers: headers }

      it 'creates a todo' do
        expect(json['title']).to eq('Operation Breakdown')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) do
        { title: nil }.to_json
      end

      before { post '/todos', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:id' do
    let(:valid_attributes) do
      { title: 'Conquer the world' }.to_json
    end

    context 'when the record exists' do
      before { put "/todos/#{todo_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}", headers: headers}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end