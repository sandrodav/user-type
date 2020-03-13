require 'rails_helper'



describe 'UserTypes API' do

  path '/users' do

    post 'Creates a user' do
      tags 'users'
      consumes 'application/json', 'application/xml'
      parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
              username: { type: :string },
              fname: { type: :string },
              lname: { type: :string },
              email: { type: :string },
              password: { type: :string },
              birthday: { type: :string},
              type_id: { type: :integer }

          },
          required: [ 'fname','lname','username','email','password','birthday','type_id']
      }

      response '201', 'usertype created' do
        let(:params) { { fname: 'name',lname: 'lastname' ,username: 'user',email: 'email@example.com',password: 'password', birthday: "#{Date.today}", type_id: 1 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:params) { { fname: 'name1',lname: 'lastname1' ,username: 'user1',email: 'email1@example.com',password: 'password1', birthday: "#{Date.today}", type_id: -1 } }
        run_test!
      end
    end
  end


  path '/users' do
    get 'show all usertypes' do
      tags 'users'
      produces 'application/json'

      response '200', 'Usertype found' do
        before { create_list(:user, 2) }

        run_test!
      end
    end
  end


  path '/users/{id}' do

    get 'Retrieves a user' do
      tags 'users'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :integer,schema: {
          type: :integer,
          required: [ 'id']
      }

      response '200', 'name found' do

        let(:id) { UserType.create(fname: 'fname1',lname: 'lname1',username:'user5',email: 'em@example.com',birthday: '2001/2/2',type_id: 2,password: 'password').id }
        run_test!
      end

      response '404', 'usertype not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Update usertype ' do
      tags 'users'
      parameter name: :id, in: :path, type: :integer
      parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
              username: { type: :string },
              fname: { type: :string },
              lname: { type: :string },
              email: { type: :string },
              birthday: { type: :string},
              type_id: { type: :integer }
          },
          required: [ 'fname','lname','username','email','birthday','type_id']
      }

      response '200', 'name found' do

        let(:id) { UserType.create(fname: 'fname1',lname: 'lname1',username:'user5',email: 'em@example.com',birthday: '2001/2/2',type_id: 2,password: 'password').id }
        run_test!
        run_test!
      end

      response '404', 'usertype not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end



  end


  path '/users/{id}' do
    delete 'Delete user' do
      tags 'users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer,schema: {
          type: :integer,
          required: [ 'id']
      }
      produces 'application/json'

      response '200', 'Destroy user' do
        let(:id) { User.destroy( id :id) }

        run_test!
      end
      response '404', 'usertype not found' do
        let(:id) { 'invalid' }
        run_test!
      end

    end
  end





end
