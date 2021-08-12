package com.wbu.util;

import java.sql.*;

public class DBUtil {
	private static Connection conn = null;
	private static PreparedStatement pstmt =  null;
	private static ResultSet rs = null;

	/**
	 *获取数据库连接
	 */
	public Connection getConnection() {
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/exp6";
		String username = "root";
		String password = "123456";
		try {
			//指定驱动程序
			Class.forName(driver);
			//建立数据库连接
			conn = DriverManager.getConnection(url,username,password);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	/**
	 * 释放资源
	 */
	public void closeAll() {
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 执行SQL语句，执行查询操作
	 */
	public ResultSet executeQuery(String prepareSql,Object[] param) {
		try {
			//得到prepareStatement对象
			pstmt = conn.prepareStatement(prepareSql);
			if(param != null) {
				for(int i = 0; i < param.length; i++) {
					//为预编译sql设置参数
					pstmt.setObject(i + 1, param[i]);
				}
			}
			//执行sql语句
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	/**
	 * 执行SQL语句，执行增、删、改操作,不能执行查询操作
	 */
	public int executeUpdate(String prepareSql,Object[] param) {
		int num = 0;
		try {
			//得到prepareStatement对象
			pstmt = conn.prepareStatement(prepareSql);
			if(param != null) {
				for(int i = 0; i < param.length; i++) {
					//为预编译sql设置参数
					pstmt.setObject(i + 1, param[i]);
				}
			}
			num = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return num;
	}
}
