# README

## RESTful API:

**GET /user**
* (optional) request params: 
```ruby
{ id: 1, first_name: 'test', last_name: 'test2', email: 'test@test.com', gov_id_number: '123342-OP-32', single_result: 'false' }
```
* ok response: 
```ruby
[{"id":1,"first_name":"name_0_id","last_name":"last_name_0_id","email":"test_id_0@test.com","gov_id_number":"0235-id-0","gov_id_type":"ID"},{"id":2,"first_name":"name_0_ssn","last_name":"last_name_0_ssn","email":"test_ssn_0@test.com","gov_id_number":"0235-ssn-0","gov_id_type":"SSN"}]
```
* error response:
```ruby
{"error":"too many records"}
```

**DELETE /user**
* (required at least one) request params:
```ruby
{ id: 1, first_name: 'test', last_name: 'test2', email: 'test@test.com', gov_id_number: '123342-OP-32'}
```
* ok response:
```ruby
{"ok":1}
```
* error response:
```ruby
{"error":"too many records"}
```