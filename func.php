<?php include 'config.php';
    
    function db($params = array())
    {
        $conn = new SQLite3('/var/simplehelpdesk.sqlite');
		
		$conn->exec("CREATE TABLE IF NOT EXISTS tbl_department (td_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, td_name TEXT NOT NULL, td_description TEXT)");
		$conn->exec("CREATE TABLE IF NOT EXISTS tbl_priority (tp_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, tp_name TEXT NOT NULL)");
		$conn->exec("CREATE TABLE IF NOT EXISTS tbl_service (ts_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ts_name TEXT NOT NULL, ts_description TEXT)");
		$conn->exec("CREATE TABLE IF NOT EXISTS tbl_ticket (tt_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, tt_user INTEGER NOT NULL, tt_subject TEXT NOT NULL, tt_department INTEGER NOT NULL, tt_service INTEGER NOT NULL, tt_priority INTEGER NOT NULL, tt_message TEXT NOT NULL, tt_status INTEGER NOT NULL, tt_created TEXT NOT NULL)");
		$conn->exec("CREATE TABLE IF NOT EXISTS tbl_user (tu_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, tu_role INTEGER NOT NULL, tu_user TEXT NOT NULL, tu_pass TEXT NOT NULL, tu_full_name TEXT NOT NULL, tu_email TEXT NOT NULL)");
		# status: 0 NEW, 1 PROCESSING, 2 PENDING, 3 CANCELLED, 4 RESOLVED, 5 CLOSED
		# role: 0 CUSTOMER, 1 TECHNICIAN, 2 ADMIN

        return $conn;
    }

    function Q_array($sql = null)
    {
        $db = db();
        
        if ($sql === null) {
            return null;
        } else {
            if ($result = $db->query($sql)) 
            {
                return $result->fetch_all(MYSQLI_ASSOC);

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
            if ($result = $db->query($sql)) 
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
                return $result->num_rows;

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
    