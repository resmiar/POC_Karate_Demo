package mock

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

/**
Run performance test using below command
mvn clean test-compile gatling:test
**/
class APIPerformaceTest extends Simulation {

  val protocol = karateProtocol(
    "/users/{id}" -> pauseFor("delete" -> 500),
    "/users" -> pauseFor("get" -> 1000, "post" -> 1000)
  )
  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val addAndDelete = scenario("add and Delete user").exec(karateFeature("classpath:packageOne/apiTests/APITest.feature@addanddelete"))

  setUp(
    addAndDelete.inject(rampUsers(10) during (60 seconds)).protocols(protocol),
  )
}