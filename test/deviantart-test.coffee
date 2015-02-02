chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'deviantart', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/deviantart')(@robot)

  # this is the very worst kind of unit test
  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/(?:deviate|deviantart|deviation) me ?(.+)?/)
