# create angular module - "Todos"
app = angular.module("Todos", ["ngResource"])

# Factory: create RESTful routes - tied to rails controller actions
# "GET" - query(), "POST" - save(), "DELETE" - remove() or delete()
# have to specify a "PUT" - update() function
app.factory "Todos", ($resource) ->
  $resource("/todos/:id.json", {id: "@id"}, {update: {method: "PUT"}})


# Directives: create template elements
app.directive "todotitle", () ->
  restrict: "E",
  template: "<h1>To Do List</h1>"

app.directive "additem", () ->
  restrict: "E",
  template: "<h3>Add Item</h3>"

app.directive "undonelist", () ->
  restrict: "E",
  template: "<h3>Things Left To Do</h3>"

app.directive "donelist", () ->
  restrict: "E",
  template: "<h3>Things That are Done</h3>"

app.directive "todocheckbox", () ->
  restrict: "E",
  template: "<input type='checkbox' ng-click='checkbox()' ng-model='todo.done' >"

# app.directive "superman", () ->
#   restrict: "A",
#   link: ->
#     alert "I'm superman!"

# shorthand syntax for an attribute directive
# app.directive "superman", () ->
#   ->
#     alert "I'm superman!"

# Controller "TodoCtrl" functions
@TodoCtrl = ($scope, Todos) ->
  # GET data from database using "query()"
  # assign database data to the "todos" variable in this scope
  $scope.todos = Todos.query() # - "GET"

  # Function "addTodo()" - "POST - save()"
  $scope.addTodo = ->
    # set done field to false
    $scope.newTodo.done = false

    # POST the new todo item using "save()"
    # store the newTodo item in the "todo" variable
    todo = Todos.save($scope.newTodo)

    # add todo to the "todos" variable to update the view real time
    $scope.todos.push(todo)

    # clear the input field
    $scope.newTodo = {}

  # Function "checkbox()" - "PUT - update()"
  $scope.checkbox = ->
    # assign the todo item that was clicked "this.todo" to the "todo" variable
    todo = @todo

    # PUT an update to the database
    todo.$update()

  # Function "delete_todo()" - "DELETE - remove() or delete()"
  $scope.delete_todo = ->
    todo = @todo

    # remove the todo item from the view
    # find index of todo in todos
    i = todos.indexOf(todo)

    # indexOf returns "-1" if the element is not found in the array
    if i != -1
      # use splice remove "1" element at index "i"
      todos.splice(i, 1)

    # delete the "todo" record from the database
    todo.$remove()



