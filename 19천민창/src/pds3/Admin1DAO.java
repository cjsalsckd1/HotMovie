package pds3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Admin1DAO {
	DBOpen dbopen = null; // 필드
	DBClose dbclose = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sql = null;

	public Admin1DAO() { // 생성자, 기본값 할당 , return type 생략, 클래스 이름과 동일
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}

	/**
	 * 단순 목록을 구합니다.
	 * 
	 * @return 목록
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
	 * 관리자 등록
	 * 
	 * @param vo
	 *            관리자 내용
	 * @return 1: 등록 성공, 0: 등록 실패
	 */
	public int insert(Admin1VO vo) {
		int count = 0; // 처리된 레코드 갯수

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
	 * 조회
	 * 
	 * @param admin1no
	 * @return 목록
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
	 * 패스워드가 일치하는지 확인합니다.
	 * 
	 * @param admin1no
	 *            회원 번호
	 * @param passwd
	 *            패스워드
	 * @return 1:일치, 0:불일치
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
			rs.next(); // 첫번째 레코드로 이동
			count = rs.getInt("cnt");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose.close(con, pstmt, rs);
		}
		return count;
	}

	/**
	 * 패스워드를 변경합니다.
	 * 
	 * @param admin1no
	 *            변경할 회원 번호
	 * @param passwd
	 *            변경할 패스워드
	 * @return 1:변경성공, 2:변경실패
	 */
	public int updatePasswd(int admin1no, String passwd) {
		Connection con = null; // DBMS 연결
		PreparedStatement pstmt = null; // SQL 실행
		StringBuffer sql = null; // SQL문
		int count = 0; // 처리된 레코드 갯수

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
			rs.next();//첫번째 레코드로 이동, 0 or
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
	 * 회원을 삭제합니다.
	 * @param admin1no 삭제할 회원 번호
	 * @return 삭제된 레코드 갯수
	 */
	public int delete(int admin1no) {
		int count = 0;	//처리된 레코드 갯수

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
