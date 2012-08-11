describe "Person", ->
  it "should have 2 hands", ->
    person = new Person
    expect(person.hands).toEqual(2)
