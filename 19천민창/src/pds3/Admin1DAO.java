package pds3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Admin1DAO {
	DBOpen dbopen = null; // �ʵ�
	DBClose dbclose = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sql = null;

	public Admin1DAO() { // ������, �⺻�� �Ҵ� , return type ����, Ŭ���� �̸��� ����
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}

	/**
	 * �ܼ� ����� ���մϴ�.
	 * 
	 * @return ���
	 */
	public ArrayList<Admin1VO> list() {
		ArrayList<Admin1VO> list = null;
		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			sql.append(" SELECT admin1no, email, mdate");
			sql.append(" FROM admin1");
			sql.append(" ORDER BY email ASC");

			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery(); // SELECT

			list = new ArrayList<Admin1VO>();
			while (rs.next() == true) {
				Admin1VO vo = new Admin1VO();
				vo.setAdmin1no(rs.getInt("admin1no"));
				vo.setEmail(rs.getString("email"));
				vo.setMdate(rs.getString("mdate"));

				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose.close(con, pstmt, rs);
		}
		return list;
	}

	/**
	 * ������ ���
	 * 
	 * @param vo
	 *            ������ ����
	 * @return 1: ��� ����, 0: ��� ����
	 */
	public int insert(Admin1VO vo) {
		int count = 0; // ó���� ���ڵ� ����

		try {
			con = dbopen.getConnection();

			sql = new StringBuffer();
			sql.append(" insert into admin1(admin1no, email, passwd, mdate)");
			sql.append(" values((select nvl(max(admin1no),0)+1 as max from admin1), ?, ?, sysdate)");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, vo.getEmail());
			pstmt.setString(2, vo.getPasswd());
			
			count = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose.close(con, pstmt);
		}
		return count;
	}

	/**
	 * ��ȸ
	 * 
	 * @param admin1no
	 * @return ���
	 */
	public Admin1VO read(int admin1no) {
		Admin1VO vo = null;
		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			sql.append(" SELECT admin1no, email, passwd, mdate");
			sql.append(" FROM admin1");
			sql.append(" WHERE admin1no = ?");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, admin1no);
			rs = pstmt.executeQuery(); // SELECT

			vo = new Admin1VO();

			vo.setAdmin1no(rs.getInt("admin1no"));
			vo.setEmail(rs.getString("email"));
			vo.setPasswd(rs.getString("passwd"));
			vo.setMdate(rs.getString("mdate"));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose.close(con, pstmt, rs);
		}
		return vo;
	}

	/**
	 * �н����尡 ��ġ�ϴ��� Ȯ���մϴ�.
	 * 
	 * @param admin1no
	 *            ȸ�� ��ȣ
	 * @param passwd
	 *            �н�����
	 * @return 1:��ġ, 0:����ġ
	 */
	public int countPasswd(int admin1no, String passwd) {
		int count = 0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			sql.append(" SELECT COUNT(*) as cnt");
			sql.append(" FROM admin1");
			sql.append(" WHEvRE admin1no=? AND passwd=?");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, admin1no);
			pstmt.setString(2, passwd);

			rs = pstmt.executeQuery(); // SELECT
			rs.next(); // ù��° ���ڵ�� �̵�
			count = rs.getInt("cnt");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose.close(con, pstmt, rs);
		}
		return count;
	}

	/**
	 * �н����带 �����մϴ�.
	 * 
	 * @param admin1no
	 *            ������ ȸ�� ��ȣ
	 * @param passwd
	 *            ������ �н�����
	 * @return 1:���漺��, 2:�������
	 */
	public int updatePasswd(int admin1no, String passwd) {
		Connection con = null; // DBMS ����
		PreparedStatement pstmt = null; // SQL ����
		StringBuffer sql = null; // SQL��
		int count = 0; // ó���� ���ڵ� ����

		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			sql.append(" UPDATE admin1");
			sql.append(" SET passwd=?");
			sql.append(" WHERE admin1no=?");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, passwd);
			pstmt.setInt(2, admin1no);

			count = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose.close(con, pstmt);
		}
		return count;
	}

	public int emailCount(String email) {
		int count = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			sql.append(" Select count(*) as cnt ");
			sql.append(" from admin1");
			sql.append(" WHERE email=?");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();//select
			rs.next();//ù��° ���ڵ�� �̵�, 0 or
			count = rs.getInt("cnt");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose.close(con, pstmt, rs);
		}
		return count;
	}
	public int update(int admin1no, String email) {
		int count = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			sql.append(" update admin1 ");
			sql.append(" set email=?");
			sql.append(" WHERE admin1no=?");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, email);
			pstmt.setInt(2, admin1no);
			
			count = pstmt.executeUpdate();
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose.close(con, pstmt);
		}
		return count;
	}
	/**
	 * ȸ���� �����մϴ�.
	 * @param admin1no ������ ȸ�� ��ȣ
	 * @return ������ ���ڵ� ����
	 */
	public int delete(int admin1no) {
		int count = 0;	//ó���� ���ڵ� ����

		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			sql.append(" delete from admin1 ");
			sql.append(" WHERE admin1no=?");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, admin1no);
			
			count = pstmt.executeUpdate();
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose.close(con, pstmt);
		}
		return count;
	}
}
