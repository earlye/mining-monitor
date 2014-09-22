#!/usr/bin/php
<?php

$this_dir_3CF6CE5B6871 = pathinfo(__FILE__,PATHINFO_DIRNAME)."/";
require_once $this_dir_3CF6CE5B6871."/"."lib/phpede/phpede.php";

$config = file_get_json( $this_dir_3CF6CE5B6871."/"."config.json" );

foreach( get_object_vars($config->mining_urls) as $name  => $url )
  {
    $dead = array();
    try
      {
        //echo "$name:$url\n";

        $data = curl_get( $url );
        $data_json = json_decode_throw( $data );

        foreach(get_object_vars($data_json->workers) as $worker_name => $worker )
          {
            if ( !$worker->alive )
              {
                array_push( $dead, $worker_name );
              }
            else
              {
                //echo "living worker: $worker_name\n";
              }
          }

      }
    catch( Exception $e )
      {
        echo "Caught exception: $e\n";
      }

    if (count($dead))
      {
        echo "The following workers are dead:".implode(",",$dead)."\n";
      }
  }

?>
