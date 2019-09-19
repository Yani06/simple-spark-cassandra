import java.time.Instant
import org.apache.spark.SparkConf
import org.apache.spark.sql.{SaveMode, SparkSession}
import com.datastax.spark.connector._

object MainApp extends App {
  println("Job started ....")

  val conf = new SparkConf().setAppName("simple-spark-cassandra")
    .set("spark.cassandra.connection.host", "127.0.0.1")

  val sparkSession = SparkSession.builder().config(conf).master("local").getOrCreate()
  val taxiRDD = sparkSession.sparkContext.cassandraTable("test", "nyc_taxi_1")
  println(taxiRDD.tableName  + " | " + taxiRDD.count())

  val rdd = taxiRDD.joinWithCassandraTable("test", "nyc_taxi_2", AllColumns)
    .on(SomeColumns("tpep_pickup_datetime", "tpep_dropoff_datetime")).left

  rdd.saveToCassandra("test", "nyc_taxi",  SomeColumns(
    "tpep_pickup_datetime",
    "tpep_dropoff_datetime",
    "dolocationid",
    "passenger_count",
    "pulocationid",
    "ratecodeid",
    "store_and_fwd_flag",
    "trip_distance",
    "vendorid"
    ))

  println("Join count = " + rdd.count())
  println("Job Finished at :" + Instant.now())

  val df = sparkSession
    .read
    .format("org.apache.spark.sql.cassandra")
    .options(Map( "table" -> "nyc_taxi", "keyspace" -> "test"))
    .load()

  df.write.mode(SaveMode.Overwrite).format("csv").option("delimiter", ";").save("/tmp/taxi")
}
