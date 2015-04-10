package com.lsphate;

import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.Date;

public class PhotosWorker {
	final static String url = "jdbc:mysql://cs4111.ckmuhiwllrah.us-west-2.rds.amazonaws.com:3306/cs4111";

	public static ArrayList<String> GetPhotos(int type) {
		ArrayList<String> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			switch (type) {
			case 1:
				rset = stmt.executeQuery("select * from photo p;");
				while (rset.next()) {
					list.add(rset.getString("photo_name"));
					list.add(rset.getString("views"));
				}
				break;
			case 2:
				rset = stmt
						.executeQuery("select * from photo p, exif e where p.pid = e.pid;");
				while (rset.next()) {
					list.add(rset.getString("photo_name"));
					list.add(rset.getString("views"));
					list.add(rset.getString("shutter"));
					list.add(rset.getString("aperture"));
					list.add(rset.getString("focal_length"));
					list.add(rset.getString("ISO"));
					list.add(rset.getString("date"));
					list.add(rset.getString("flash"));
					list.add(rset.getString("size"));
				}
				break;
			case 3:
				rset = stmt
						.executeQuery("select * from photo p, taken_by tb where p.pid = tb.pid;");
				while (rset.next()) {
					list.add(rset.getString("photo_name"));
					list.add(rset.getString("views"));
					list.add(rset.getString("device_name"));
					list.add(rset.getString("lenses_name"));
				}
				break;
			case 4:
				rset = stmt
						.executeQuery("select * from photo p, exif e, taken_by tb where p.pid = e.pid && p.pid = tb.pid;");
				while (rset.next()) {
					list.add(rset.getString("photo_name"));
					list.add(rset.getString("views"));
					list.add(rset.getString("shutter"));
					list.add(rset.getString("aperture"));
					list.add(rset.getString("focal_length"));
					list.add(rset.getString("ISO"));
					list.add(rset.getString("date"));
					list.add(rset.getString("flash"));
					list.add(rset.getString("size"));
					list.add(rset.getString("device_name"));
					list.add(rset.getString("lenses_name"));
				}
				break;
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static ArrayList<String> GetUsers() {
		ArrayList<String> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			rset = stmt.executeQuery("select display_name from user;");
			while (rset.next()) {
				list.add(rset.getString("display_name"));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static void NewUsers(String newusername, String newemail,
			String newpassword) {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			String display_name = newusername, username = newemail, password = newpassword;
			stmt.executeUpdate("INSERT INTO user (display_name, username, password) VALUES ( \""
					+ display_name
					+ "\", \""
					+ username
					+ "\", \""
					+ password
					+ "\");");
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static ArrayList<String> GetUserAlbums(String user) {
		ArrayList<String> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			String q = "select temp1.album_name, temp1.views, temp1.date, temp2.num "
					+ "from (select cb.album_name, a.views, cb.date from user u, album a, created_by cb where u.uid = cb.uid && cb.album_name = a.album_name && u.display_name = \""
					+ user
					+ "\") temp1, (select album_name, count(pid) as num from collection group by album_name) temp2 where temp1.album_name = temp2.album_name;";
			rset = stmt.executeQuery(q);
			while (rset.next()) {
				list.add(rset.getString("album_name"));
				list.add(rset.getString("views"));
				list.add(rset.getString("date"));
				list.add(rset.getString("num"));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static ArrayList<String> GetUserPhotos(String user) {
		ArrayList<String> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			String q = "select p.photo_name, p.views, ub.date, c.album_name "
					+ "from user u, uploaded_by ub, photo p "
					+ "left outer join collection c on p.pid = c.pid "
					+ "where u.uid = ub.uid && p.pid = ub.pid && u.display_name = \""
					+ user + "\";";
			rset = stmt.executeQuery(q);
			while (rset.next()) {
				list.add(rset.getString("photo_name"));
				list.add(rset.getString("views"));
				list.add(rset.getString("date"));
				list.add(rset.getString("album_name"));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static ArrayList<String> GetTags() {
		ArrayList<String> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			rset = stmt.executeQuery("select tag_name from tags;");
			while (rset.next()) {
				list.add(rset.getString("tag_name"));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static ArrayList<String> GetTagsTable(String[] tags) {
		ArrayList<String> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			String temp;
			String query = "";
			for (int i = 0; i < tags.length; i++) {
				if (i == 0)
					temp = "t.tag_name = \"" + tags[i] + "\"";
				else
					temp = "or t.tag_name = \"" + tags[i] + "\"";
				query += temp;
			}

			rset = stmt
					.executeQuery("select t.tag_name, p.photo_name, p.pid, p.views from tagged t, photo p where ("
							+ query + ") AND t.pid = p.pid order by tag_name;");
			while (rset.next()) {
				list.add(rset.getString("tag_name"));
				list.add(rset.getString("photo_name"));
				list.add(rset.getString("views"));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static boolean IsAuthorized(String email, String password) {
		Connection conn = null;
		ResultSet rset = null;
		boolean exists = false;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			rset = stmt.executeQuery("select * from user where username = '"
					+ email + "' && password = '" + password + "';");
			exists = rset.next();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return exists;
	}

	public static void InsertPhoto(String username, String filename, int views,
			String tags) {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			String q = "INSERT INTO photo (photo_name, views) VALUES ('"
					+ filename + "', " + views + ");";
			// System.out.println(q);
			Statement stmt = conn.createStatement();
			stmt.executeUpdate(q);
			int pid = GetSpecPid(filename);
			int uid = GetSpecUid(username);
			DateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
			Date date = Calendar.getInstance().getTime();
			String today = formatter.format(date);
			q = "insert into uploaded_by values (" + pid + ", " + uid + ", \""
					+ today + "\");";
			stmt.executeUpdate(q);
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static int GetSpecPid(String filename) {
		int pid = 0;
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			rset = stmt
					.executeQuery("select pid from photo where photo_name = \""
							+ filename + "\";");
			while (rset.next()) {
				pid = Integer.parseInt(rset.getString("pid"));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pid;
	}

	public static int GetSpecUid(String username) {
		int uid = 0;
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			rset = stmt.executeQuery("select uid from user where username = \""
					+ username + "\";");
			while (rset.next()) {
				uid = Integer.parseInt(rset.getString("uid"));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return uid;
	}

	public static ArrayList<String> GetMakers() {
		ArrayList<String> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			rset = stmt.executeQuery("select distinct maker from devices;");
			while (rset.next()) {
				list.add(rset.getString("maker"));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static ArrayList<String> GetDevices(String maker) {
		ArrayList<String> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			rset = stmt
					.executeQuery("select device_name from devices where maker = \""
							+ maker + "\";");
			while (rset.next()) {
				list.add(rset.getString("device_name"));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static ArrayList<String> GetDevicePhotos(String device) {
		ArrayList<String> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			rset = stmt
					.executeQuery("select u.display_name, p.photo_name, p.views, ub.date, temp.lenses_name "
							+ "from user u, photo p, uploaded_by ub, (select * from taken_by where device_name = \""
							+ device
							+ "\") temp where p.pid = temp.pid && p.pid = ub.pid && u.uid = ub.uid;");
			while (rset.next()) {
				list.add(rset.getString("display_name"));
				list.add(rset.getString("photo_name"));
				list.add(rset.getString("views"));
				list.add(rset.getString("date"));
				list.add(rset.getString("lenses_name"));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static ArrayList<String> AdvSearchUser(String search) {
		ArrayList<String> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			String q = "SELECT* from user where display_name = \"" + search
					+ "\";";
			// System.out.println(q);
			list.add("from User Table : ");
			Statement stmt = conn.createStatement();
			rset = stmt.executeQuery(q);
			while (rset.next()) {
				list.add(rset.getString("uid"));
				list.add(rset.getString("display_name"));
				list.add(rset.getString("username"));
				list.add(rset.getString("password"));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static ArrayList<String> AdvSearchAlbum(String search) {
		ArrayList<String> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			String q = "SELECT* from album where album_name = \"" + search
					+ "\";";
			// System.out.println(q);
			list.add("from Album Table : ");
			Statement stmt = conn.createStatement();
			rset = stmt.executeQuery(q);
			while (rset.next()) {
				list.add(rset.getString("album_name"));
				list.add(rset.getString("views"));
			}

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static ArrayList<String> AdvSearchPhoto(String search) {
		ArrayList<String> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			String q = "SELECT* from photo where photo_name = \"" + search
					+ "\";";
			// System.out.println(q);
			list.add("from Photo Table : ");
			Statement stmt = conn.createStatement();
			rset = stmt.executeQuery(q);
			while (rset.next()) {
				list.add(rset.getString("pid"));
				list.add(rset.getString("photo_name"));
				list.add(rset.getString("views"));
			}

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static ArrayList<String> AdvSearchDevice(String search) {
		ArrayList<String> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			String q = "SELECT* from devices where device_name = \"" + search
					+ "\";";
			// System.out.println(q);
			list.add("from Device Table : ");
			Statement stmt = conn.createStatement();
			rset = stmt.executeQuery(q);
			while (rset.next()) {
				list.add(rset.getString("device_name"));
				list.add(rset.getString("maker"));
			}

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
