# TodoWizard 🧙‍♂️✨

Welcome to **TodoWizard**, the magical Todo list application that turns your tasks into a spellbinding adventure! Organize your day, conquer your to-dos, and master the art of productivity with a sprinkle of wizardry. Whether you're a busy sorcerer or just someone looking to keep their tasks in check, TodoWizard has the enchantments you need.

## Features
- 🔮 Mystical task management
- ✨ Enchanted user interface
- 🧹 Seamless task sorting
- 📅 Spellbinding calendar integration
- 📚 And much more magical goodness!

Join the adventure and wave your wand over your to-do list with TodoWizard! 🧙‍♂️✨

# Installation 
Follow the instructions to install Elixir 1.16-opt-26 [Elixir Lang Org Page](https://elixir-lang.org/install.html) 
If you have a different version of Elixir installed, I recommend using asdf for version management. 
For more information visit [asdf homepage](https://asdf-vm.com/guide/getting-started.html)

# Run the app
To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * To connect with the API, is necessary to make HTTP request to your local endpoint http://localhost:4000/api/v1/ 
# Endpoints 

## Users 
Endpoint to register user information

### Create
Send an HTTP request to POST `http://localhost:4000/api/v1/users` with the following JSON data

```json
{
	"user": {
		"first_name": "Cesar",
		"last_name": "Jolibois",
		"username": "diazblack" # required field, this field must be unique 
	}
}
```
Returns a 201 response with: 

 ```json
 {
	"data": {
		"id": "09bb64cd-858f-4701-86fc-e7d983940e84",
		"first_name": "Cesar",
    "first_name": "Cesar",
		"last_name": "Jolibois",
	}
} 
 ```

### Update 
Send an HTTP request to PUT `http://localhost:4000/api/v1/users/:username` to update any field from the users table.
**Note:** The username should be added to the URL, to make the endpoint work 
```json
{
	"user": {
		"first_name": "Cesar",
		"last_name": "Jolibois",
		"username": "diazblack" # this field must be unique 
}
```

Returns a 200 response

### Show 
Send an HTTP request to GET `http://localhost:4000/api/v1/users/:username` to get user information 

**Note:** The username should be added to the URL, to make the endpoint work 

Returns a 200 response with the following data 

```json
{
	"data": {
		"id": "09bb64cd-858f-4701-86fc-e7d983940e84",
		"username": "diazblack",
		"first_name": "Cesar",
		"last_name": "Jolibois"
	}
}
```

### DELETE 


Send an HTTP request to DELETE `http://localhost:4000/api/v1/users/:username` to delete the user entry 
**Note:** The username should be added to the URL, to make the endpoint work 
Returns a 204 when the entry is deleted, 404 in any other case 

## Todo Lists 
Endpoint to handle Todo List information 
### Create
Send an HTTP request to POST `http://localhost:4000/api/v1/todo_lists` with the following JSON data

```json
{
	"todo_list": {
		"title": "To Create An App", # required field,
		"description": "Some Random description",
		"user_id": "09bb64cd-858f-4701-86fc-e7d983940e84" # required field,
	}
}
```
Returns a 201 response with: 

 ```json
{
	"data": {
		"id": "d891c246-e5f9-45c1-b19f-d008302d5bc3",
		"description": "Some Random description",
		"title": "To Create An App",
		"user_id": "09bb64cd-858f-4701-86fc-e7d983940e84"
	}
} 
 ```

### Update 
Send an HTTP request to PUT `http://localhost:4000/api/v1/todo_lists/:id` to update fields from todo list table.

**Note:** The username should be added to the URL, to make the endpoint work 
```json
{
	"todo_list": {
		"title": "To Create An App", # required field,
		"description": "Some Random description",
		"user_id": "09bb64cd-858f-4701-86fc-e7d983940e84" # required field,
	}
}
```

Returns a 200 

### Show 
Send an HTTP request to GET `http://localhost:4000/api/v1/todo_lists/:id` to get todo list and todo items information 

**Note 1:** The username should be added to the URL, to make the endpoint work 
**Note 2:** This endpoint should be used to get all the Todo Items for a Todo List

Returns a 200 response with the following data 

```json
{
	"data": {
		"id": "d891c246-e5f9-45c1-b19f-d008302d5bc3",
		"description": "Some Random description",
		"title": "To Create An App",
		"todo_items": [
			{
				"id": "ecdd3242-9b2d-44bc-8295-3fe3b9eb4268",
				"description": "Generate a new phoenix application",
				"title": "Create new Local App",
				"is_checked": true,
				"todo_list_id": "d891c246-e5f9-45c1-b19f-d008302d5bc3"
			}
		],
		"user_id": "09bb64cd-858f-4701-86fc-e7d983940e84"
	}
}
```

### DELETE

Send an HTTP request to DELETE `http://localhost:4000/api/v1/todo_lists/:id` to delete the user entry  
**Note:** The username should be added to the URL, to make the endpoint work 
Return a 204 when the entry is deleted, 404 in any other case 

## Todo Items 
Endpoint to handle Todo Items information 

### Create
Send an HTTP request to POST `http://localhost:4000/api/v1/todo_items` with the following JSON data

```json
{
	"todo_item": {
		"title": "Create new Local App",
		"description": "Generate a new phoenix application",
		"is_checked": true,
		"todo_list_id": "d891c246-e5f9-45c1-b19f-d008302d5bc3"
	}
}
```
Returns a 201 response with: 

 ```json
{
	"data": {
		"id": "ecdd3242-9b2d-44bc-8295-3fe3b9eb4268",
		"description": "Generate a new phoenix application", # required field
		"title": "Create new Local App",
		"is_checked": true, # required field
		"todo_list_id": "d891c246-e5f9-45c1-b19f-d008302d5bc3" # required field
	}
} 
 ```

### Update 

Send an HTTP request to PUT `http://localhost:4000/api/v1/todo_items/:id` to update fields from todo list table.
**Note:** The username should be added to the URL, to make the endpoint work 

```json
{
	"data": {
		"id": "ecdd3242-9b2d-44bc-8295-3fe3b9eb4268",
		"description": "investigate error on Erlang after DB installation", # required field
		"title": "Installation Bug",
		"is_checked": false, # required field
		"todo_list_id": "d891c246-e5f9-45c1-b19f-d008302d5bc3" # required field
	}
}
```

Returns a 200 

### Show 
Send an HTTP request to GET `http://localhost:4000/api/v1/todo_items/:id` to get todo list and todo items information 
**Note:** The username should be added to the URL, to make the endpoint work 

Returns a 200 response with the following data 

```json
{
	"data": {
		"id": "ecdd3242-9b2d-44bc-8295-3fe3b9eb4268",
		"description": "Generate a new phoenix application",
		"title": "Create new Local App",
		"is_checked": true,
		"todo_list_id": "d891c246-e5f9-45c1-b19f-d008302d5bc3"
	}
}
```

### Delete
Send an HTTP request to DELETE `http://localhost:4000/api/v1/todo_items/:id` to delete the user entry  
**Note:** The username should be added to the URL, to make the endpoint work 

Returns a 204 when the entry is deleted, 404 in any other case 

### Done 
Send an HTTP request to PUT `http://localhost:4000/api/v1/todo_items/done/:id` to set the Todo Item as complete.
**Note:** The username should be added to the URL, to make the endpoint work 

entry before hitting the endpoint 

```json
{
	"data": {
		"id": "d1623ae7-4507-436a-8fc2-67ff5d28dc81",
		"description": "Just for test",
		"title": "Test Item",
		"todo_list_id": "d891c246-e5f9-45c1-b19f-d008302d5bc3",
		"is_checked": false
	}
} 
```

Returns a 200 response with the following data 

```json
{
	"data": {
		"id": "d1623ae7-4507-436a-8fc2-67ff5d28dc81",
		"description": "Just for test",
		"title": "Test Item",
		"todo_list_id": "d891c246-e5f9-45c1-b19f-d008302d5bc3",
		"is_checked": true
	}
}
```

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
