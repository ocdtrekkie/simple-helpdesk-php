<?php include 'config.php';
    
    function db($params = array())
    {
        $conn = new SQLite3('/var/data.sqlite');

        if (!$conn) {
            die("Connection failed: " . $conn->lastErrorMsg());
        }
		
        $cnt = $conn->querySingle("SELECT count(*) FROM sqlite_master WHERE type='table' AND name='tbl_user';");
        if ($cnt === 0) {
            $sql = file_get_contents('/opt/app/db_shd_sqlite.sql');
            $conn->exec($sql);
            $conn->exec('PRAGMA journal_mode = wal;');
        }

        return $conn;
    }
	
    // Thanks https://stackoverflow.com/a/77786660
    function sqliteFetchAll(\SQLite3Result $results, $mode = SQLITE3_ASSOC): array
    {
        $multiArray = [];
        while($result = $results->fetchArray($mode)) {
            $multiArray[] = $result;
        }
        return $multiArray;
    }

    function Q_array($sql = null)
    {
        $db = db();
        
        if ($sql === null) {
            return null;
        } else {
            if ($result = $db->query($sql)) 
            {
                return sqliteFetchAll($result, SQLITE3_ASSOC);

                $result->free();
            }

            /* close connection */
            $db->close();
        }
    }

    function Q_execute($sql = null)
    {
        $db = db();
        
        if ($sql === null) {
            return null;
        } else {
            if ($result = $db->exec($sql)) 
            {
                return $result;

                $result->free();
            }

            /* close connection */
            $db->close();
        }
    }

    function Q_count($sql = null)
    {
        $db = db();
        
        if ($sql === null) {
            return null;
        } else {
            if ($result = $db->query($sql)) 
            {
                return count(sqliteFetchAll($result, SQLITE3_ASSOC));

                $result->free();
            }

            /* close connection */
            $db->close();
        }
    }

    function Q_mres($param = null){
        $db = db();

        if ($param === null) {
            return null;
        } else {
            return $db->escapeString($param); 
        }
    }

    function redirect_to($page=null, $time=0.1)
    {
        if($page !== null){
            echo "<meta http-equiv='refresh' content='". $time ."; url=". $page ."'>";
        }
    }

    function site_url($slash=false)
    {
        $dir_project = CONF_DIR_PROJECT;
        $http_host = $_SERVER['HTTP_HOST'];
        $https_check = (!empty($_SERVER['HTTPS']) ? 'https' : 'http');

        if($slash){
            $siteurl =  $https_check . '://' . $http_host . '/';
        } else {
            $siteurl =  $https_check . '://' . $http_host;
        }

        return $siteurl;
    }

    function your_position(){
        $actual_link = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
        return $actual_link;
    }

    function session_me(){
        if(isset($_SESSION['login'])){
            if($_SESSION['login']){
                return true;
            }
        }

        return false;
    }

    /*function base_url($extnd = null)
    {
        $http = 'http' . ((isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') ? 's' : '') . '://';
        $url = str_replace("/index.php","", $_SERVER['SCRIPT_NAME']);
        $parse_url = explode("/", $url);
        $parse_url_end = end($parse_url);
        $clean_url = str_replace($parse_url_end, "", $url);

        if ($extnd == null)
        {
            $final_url = $clean_url;
        } else {
            $final_url = $clean_url . "" . $extnd;
        }

        $ret = "$http" . $_SERVER['SERVER_NAME'] . "" . $final_url;

        return  $ret;
    }

    function site_url($extnd = null)
    {
        $http = 'http' . ((isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') ? 's' : '') . '://';
        $url = str_replace("/index.php","", $_SERVER['SCRIPT_NAME']);

        if ($extnd == null)
        {
            $final_url = $url;
        } else {
            $final_url = $url."/".$extnd;
        }

        $ret = "$http" . $_SERVER['SERVER_NAME'] . "" . $final_url;

        return $ret;
    }*/
    