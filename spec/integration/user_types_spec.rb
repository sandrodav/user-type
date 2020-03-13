require 'rails_helper'



describe 'UserTypes API' do

  path '/usertypes' do

    post 'Creates a usertype' do
      tags 'new'
      consumes 'application/json', 'application/xml'
      parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },

          },
          required: [ 'name']
      }

      response '201', 'usertype created' do
        let(:params) { { name: 'user' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:params) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/usertypes' do
    get 'Retrieves all usertypes' do
      tags 'index'
      produces 'application/json'

      response '200', 'Usertype found' do
        before { create_list(:usertype, 2) }

        run_test!
      end
    end
  end

  path '/usertypes/{id}' do

    get 'Retrieves a usertype' do
      tags 'show'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :integer,schema: {
          type: :integer,
          required: [ 'id']
      }

      response '200', 'name found' do

        let(:id) { UserType.create(name: 'user').id }
        run_test!
      end

      response '404', 'usertype not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end



    put 'Update usertype ' do
      tags 'update'
      parameter name: :id, in: :path, type: :integer
      parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string }
          },
          required: ['name']
      }

      response '200', 'name found' do

        let(:params) { UserType.create(name: 'user').id }
        run_test!
      end

      response '404', 'usertype not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/usertypes/{id}' do
    delete 'Delete usertype' do
      tags 'destroy'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer,schema: {
          type: :integer,
          required: [ 'id']
      }
      produces 'application/json'

      response '200', 'Destroy usertype' do
        let(:id) { UserType.destroy( :id) }

        run_test!
      end
      response '404', 'usertype not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end



end
