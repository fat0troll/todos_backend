require 'rails_helper'

RSpec.describe 'Tasks API' do
  let!(:user) { create(:user) }
  let!(:todo) { create(:todo, user_id: user.id) }
  let!(:tasks) { create_list(:task, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { tasks.first.id }
  let(:headers) { valid_headers }

  describe 'GET /todos/:todo_id/tasks' do
    before { get "/todos/#{todo_id}/tasks", params: {}, headers: headers }

    context 'when todo exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all todo items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when todo does not exist' do
      let(:todo_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'GET /todos/:todo_id/tasks/:id' do
    before { get "/todos/#{todo_id}/tasks/#{id}", params: {}, headers: headers }

    context 'when task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the task' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when task does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  describe 'POST /todos/:todo_id/tasks' do
    let(:valid_attributes) do
      { name: 'Capture the flag', done: false }.to_json
    end

    context 'when request attributes are valid' do
      before { post "/todos/#{todo_id}/tasks", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/todos/#{todo_id}/tasks", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:todo_id/tasks/:id' do
    let(:valid_attributes) do
      { name: 'Reinhardt' }.to_json
    end

    before { put "/todos/#{todo_id}/tasks/#{id}", params: valid_attributes, headers: headers }

    context 'when task exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the task' do
        updated_item = Task.find(id)
        expect(updated_item.name).to match(/Reinhardt/)
      end
    end

    context 'when the task does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}/tasks/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end