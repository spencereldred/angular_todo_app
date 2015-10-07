var app = angular.module("Todos", ["ngResource"]);

app.factory('Todos', ['$resource', function($resource){
  return $resource('/todos/:id.json', {id: '@id'}, {update: {method: 'PUT'}});
}]);


// Directives: create template elements
app.directive("todotitle", [function() {
  return {
    restrict: "E",
    template: "<h1>Da Costco List</h1>"
  }
}]);
app.directive("additem", [function() {
  return {
    restrict: "E",
    template: "<h2>Add Item</h2>"
  }
}]);
app.directive("undonelist", [ function() {
  return {
    restrict: "E",
    template: "<h2>Shopping List</h2>"
  }
}]);
app.directive("donelist", [function() {
  return {
    restrict: "E",
    template: "<h2>Future Items</h2>"
  }
}]);
app.directive("doneButton", [function() {
  return {
    restrict: "E",
    template: "<button class='btn btn-success btn-sm' style='margin-bottom: 15px;' ng-click='update()' ng-model='todo.done'>Done</button>"
  }
}]);
app.directive("buyButton", [function() {
  return {
    restrict: "E",
    template: "<button class='btn btn-primary btn-sm' style='margin-bottom: 15px;' ng-click='update()' ng-model='todo.done'>Buy</button>"
  }
}]);


app.controller('TodoCtrl', ['$scope', '$resource', 'Todos',
  function($scope, $resource, Todos){
    $scope.todos = Todos.query();

    // Function "addTodo()" - "POST - save()"
    $scope.addTodo = function() {
      // set done field to false
      $scope.newTodo.done = false

      // POST the new todo item using "save()"
      // store the newTodo item in the "todo" variable
      var todo = Todos.save($scope.newTodo)

      // add todo to the "todos" variable to update the view real time
      $scope.todos.push(todo)

      // clear the input field
      $scope.newTodo = {}
    };

    // Function "checkbox()" - "PUT - update()"
    $scope.update = function () {
      // assign the todo item that was clicked "this.todo" to the "todo" variable
      var todo = this.todo;
      todo.done = !todo.done;

      // PUT an update to the database
      todo.$update();
    };

    // Function "delete_todo()" - "DELETE - remove() or delete()"
    $scope.delete_todo = function () {
      var todo = this.todo;
      var todos = $scope.todos;
      // remove the todo item from the view
      var i = todos.indexOf(todo);
      if (i != -1) {
        todos.splice(i, 1);
      }

      //delete the "todo" record from the database
      todo.$remove();
    };





  }
]);









