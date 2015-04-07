package com.lsphate;
import java.sql.*;
import java.util.*;

public class PhotosWorker {
	final static String url = "jdbc:mysql://cs4111.ckmuhiwllrah.us-west-2.rds.amazonaws.com:3306/cs4111";

	public static ArrayList<String> GetPhotos(int type) {
		ArrayList<String> list = new ArrayList<String>();
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
		} catch (Exception ex) {
		}
		return list;
	}

	public static ArrayList<String> GetUsers() {
		ArrayList<String> list = new ArrayList<String>();
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
		} catch (Exception ex) {
		}
		return list;
	}

	public static void NewUsers(String newusername, String newemail, String newpassword) {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			String display_name=newusername, username=newemail, password=newpassword;
			//System.out.println("INSERT INTO user (display_name, username, password) VALUES (" + display_name + ", " + username + ", " + password + ");");
			stmt.executeUpdate("INSERT INTO user (display_name, username, password) VALUES ( \"" + display_name + "\", \"" + username + "\", \"" + password + "\");");
			conn.close();
		} catch (Exception ex) {
		}
	}

	public static ArrayList<String> GetUserAlbums(String user) {
		ArrayList<String> list = new ArrayList<String>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			String q = "select cb.album_name, a.views, cb.date from user u, album a, created_by cb where u.uid = cb.uid && cb.album_name = a.album_name && u.display_name = \"" + user + "\";";
			rset = stmt.executeQuery(q);
			while (rset.next()) {
				list.add(rset.getString("album_name"));
				list.add(rset.getString("views"));
				list.add(rset.getString("date"));
			}
			conn.close();
		} catch (Exception ex) {
		}
		return list;
	}

	public static ArrayList<String> GetUserPhotos(String user) {
		ArrayList<String> list = new ArrayList<String>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			String q = "select p.photo_name, p.views, ub.date from user u, photo p, uploaded_by ub where u.uid = ub.uid && p.pid = ub.pid && u.display_name = \"" + user + "\";";
			//System.out.println(q);
			rset = stmt.executeQuery(q);
			while (rset.next()) {
				list.add(rset.getString("photo_name"));
				list.add(rset.getString("views"));
				list.add(rset.getString("date"));
			}
			conn.close();
		} catch (Exception ex) {
		}
		return list;
	}

	public static ArrayList<String> GetTags() {
		ArrayList<String> list = new ArrayList<String>();
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
		} catch (Exception ex) {
		}
		return list;
	}

	public static ArrayList<String> GetTagsTable(String[] tags) {
		ArrayList<String> list = new ArrayList<String>();
		Connection conn = null;
		ResultSet rset = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hc2751", "database");
			Statement stmt = conn.createStatement();
			String temp;
			String query = "";
			for(int i = 0; i < tags.length; i++) {
				if (i == 0) temp = "t.tag_name = \"" + tags[i] + "\"";
				else temp = "or t.tag_name = \"" + tags[i] + "\"";
				query += temp;
			}

			rset = stmt.executeQuery("select t.tag_name, p.photo_name, p.pid, p.views from tagged t, photo p where (" + query +") AND t.pid = p.pid order by tag_name;");
			while (rset.next()) {
				list.add(rset.getString("tag_name"));
				list.add(rset.getString("photo_name"));
				list.add(rset.getString("views"));
			}
			conn.close();
		} catch (Exception ex) {
		}
		return list;
	}

}
