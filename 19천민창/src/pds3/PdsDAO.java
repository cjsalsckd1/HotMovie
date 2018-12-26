package pds3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class PdsDAO {
	DBOpen dbopen = null;
	DBClose dbclose = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sql = null;
	public PdsDAO() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}
	public int insert(PdsVO pdsVO)	{
	
	int count = 0;
	
	try {
		con = dbopen.getConnection();
		sql = new StringBuffer();
		sql = sql.append("insert into pds3(pdsno, rname, email, title, content, passwd, cnt, rdate, url, file1, size1)");
		sql.append("values((select nvl(max(pdsno),0)+1 as max from pds3),");
		sql.append("?, ?, ?, ?, ?, 0, sysdate, ?, ?, ?)");
		
		pstmt = con.prepareStatement(sql.toString());
		pstmt.setString(1, pdsVO.getRname());
		pstmt.setString(2, pdsVO.getEmail());
		pstmt.setString(3, pdsVO.getTitle());
		pstmt.setString(4, pdsVO.getContent());
		pstmt.setString(5, pdsVO.getPasswd());
		pstmt.setString(6, pdsVO.getUrl());
		pstmt.setString(7, pdsVO.getFile1());
		pstmt.setLong(8, pdsVO.getSize1());
		
		count = pstmt.executeUpdate();
		
	}catch(Exception e) {
		e.printStackTrace();
	}finally {
		dbclose.close(con, pstmt);
	}
	return count;
	}
	public ArrayList<PdsVO> list(){
		ArrayList<PdsVO> list = new ArrayList<PdsVO>();
		
		try {
			con = dbopen.getConnection();
			
			sql = new StringBuffer();
			sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1 from pds3 order by pdsno desc");
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			//rs.next(): 최초 호출시 첫번재 레코드로 이동
			//rs.next(): 마지막 레코드까지 순차적으로 자동 이동
			
			while(rs.next()==true) {
				//DBMS --> JAVA 객체로 변환
				PdsVO pdsVO = new PdsVO();
				pdsVO.setPdsno(rs.getInt("pdsno"));
				pdsVO.setRname(rs.getString("rname"));
				pdsVO.setEmail(rs.getString("email"));
				pdsVO.setTitle(rs.getString("title"));
				pdsVO.setPasswd(rs.getString("Passwd"));
				pdsVO.setCnt(rs.getInt("cnt"));
				pdsVO.setRdate(rs.getString("rdate"));
				pdsVO.setUrl(rs.getString("url"));
				pdsVO.setFile1(rs.getString("file1"));
				pdsVO.setSize1(rs.getLong("size1"));
				
				list.add(pdsVO);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con, pstmt, rs);//메모리 해제
		}
		return list;
	}
	public void increaseCnt(int pdsno) {
		try {
			con=dbopen.getConnection();
			sql = new StringBuffer();
			sql.append("update pds3 set cnt = cnt+1 where pdsno=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			
			pstmt.executeUpdate();	//실행, insert 갯수 리턴
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con, pstmt);//메모리 해제
		}
	}
	/**
	 * 조회
	 * @param pdsno
	 * @return */
	public PdsVO read(int pdsno) {
		PdsVO pdsVO = null;
		
		try {
			con = dbopen.getConnection();
			
			sql = new StringBuffer();
			sql.append("select pdsno, rname, email, title, content, passwd, cnt, rdate, url, file1, size1 from pds3 where pdsno =?");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			
			rs = pstmt.executeQuery();
			
			//rs.next(): 최초 호출시 첫번째 레코드로 이동
			//rs.next(): 마지막 레코드까지 순차적으로 자동 이동
			if(rs.next()==true) {
				//DBMS --> JAVA 객체로 변환
				pdsVO = new PdsVO();
				pdsVO.setPdsno(rs.getInt("pdsno"));
				pdsVO.setRname(rs.getString("rname"));
				pdsVO.setEmail(rs.getString("email"));
				pdsVO.setTitle(rs.getString("title"));
				pdsVO.setContent(rs.getString("content"));
				pdsVO.setPasswd(rs.getString("passwd"));
				pdsVO.setCnt(rs.getInt("cnt"));
				pdsVO.setRdate(rs.getString("rdate"));
				pdsVO.setUrl(rs.getString("url"));
				pdsVO.setFile1(rs.getString("file1"));
				pdsVO.setSize1(rs.getLong("size1"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con, pstmt, rs);
		}
		return pdsVO;
	}
	/**
	 * 검색된 레코드 갯수를 구합니다.
	 * @param col 검색 컬럼
	 * @param word 검색어
	 * @return 검색된 레코드 갯수
	 */
	public int count(String col, String word) {
		int count = 0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			
			if(col.equals("rname")) {
				sql.append("select count(*) as cnt from pds3 where rname like ?");
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, "%"+word+"%");
				
			}else if(col.equals("title")) {
				sql.append("select count(*) as cnt from pds3 where title like ?");
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, "%"+word+"%");
			}else if(col.equals("content")) {
				sql.append("select count(*) as cnt from pds3 where content like ?");
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, "%"+word+"%");
			}else if(col.equals("title_content")) {
				sql.append("select count(*) as cnt from pds3 where title like ? or content like ?");
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, "%"+word+"%");
				pstmt.setString(2, "%"+word+"%");
			}else {
				sql.append("select count(*) as cnt from pds3 order by pdsno desc");
				
				pstmt = con.prepareStatement(sql.toString());
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next() == true) {
				count = rs.getInt("cnt");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con, pstmt, rs);
		}
		return count;
	}
	/**
	 * 검색 목록을 가져옵니다.
	 * @param col 검색 컬럼
	 * @param word 검색어
	 * @param nowPage 현재 페이지
	 * @return 검색된 레코드 목록
	 */
	public ArrayList<PdsVO> list(String col, String word, int nowPage, int recordPerPage){
		ArrayList<PdsVO> list = new ArrayList<PdsVO>();
		
		int startRow = ((nowPage-1)*recordPerPage)+1;
		int endRow = nowPage*recordPerPage;
		
		/*
		 1) 1 페이지 : 1~10번 레코드, r>=1 and r<=10
		 int startRow = ((1-1)*10)+1 -> 1
		 int endRow = 1*10 -> 10
		 
		  2) 2 페이지 : 10~20번 레코드, r>=10 and r<=20
		 int startRow = ((2-1)*10)+1 -> 11
		 int endRow = 2*10 -> 20
		 
		  3) 3 페이지 : 20~30번 레코드, r>=20 and r<=30
		 int startRow = ((3-1)*10)+1 -> 21
		 int endRow = 3*10 -> 30
		 */
		
		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			
			if(col.equals("rname")) {
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1, r");
				sql.append(" from (");
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1, rownum as r");
				sql.append(" from (");
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1");
				sql.append(" from pds3");
				sql.append(" where rname like ?");
				sql.append(" order by pdsno desc");
				sql.append(")");
				sql.append(")");
				sql.append("where r >=" + startRow + " and r <="+ endRow);
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, "%"+word+"%");
			
			}else if(col.equals("title")) {
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1, r");
				sql.append(" from (");
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1, rownum as r");
				sql.append(" from (");
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1");
				sql.append(" from pds3");
				sql.append(" where title like ?");
				sql.append(" order by pdsno desc");
				sql.append(")");
				sql.append(")");
				sql.append("where r >=" + startRow + " and r <="+ endRow);
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, "%"+word+"%");
			}else if(col.equals("content")) {
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1, r");
				sql.append(" from (");
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1, rownum as r");
				sql.append(" from (");
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1");
				sql.append(" from pds3");
				sql.append(" where content like ?");
				sql.append(" order by pdsno desc");
				sql.append(")");
				sql.append(")");
				sql.append("where r >=" + startRow + " and r <="+ endRow);
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, "%"+word+"%");
			}else if(col.equals("title_content")) {
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1, r");
				sql.append(" from (");
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1, rownum as r");
				sql.append(" from (");
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1");
				sql.append(" from pds3");
				sql.append(" where title like ? or content like ?");
				sql.append(" order by pdsno desc");
				sql.append(")");
				sql.append(")");
				sql.append("where r >=" + startRow + " and r <="+ endRow);
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, "%"+word+"%");
			}else {
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1, r");
				sql.append(" from (");
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1, rownum as r");
				sql.append(" from (");
				sql.append("select pdsno, rname, email, title, passwd, cnt, rdate, url, file1, size1");
				sql.append(" from pds3");
				sql.append(" order by pdsno desc");
				sql.append(")");
				sql.append(")");
				sql.append("where r >=" + startRow + "   and r <="+ endRow);
				
				pstmt = con.prepareStatement(sql.toString());
				
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next() == true) {
				//DBMS --> java 객체로 변환
				PdsVO pdsVO = new PdsVO();
				pdsVO.setPdsno(rs.getInt("pdsno"));
				pdsVO.setRname(rs.getString("rname"));
				pdsVO.setEmail(rs.getString("email"));
				pdsVO.setTitle(rs.getString("title"));
				pdsVO.setPasswd(rs.getString("passwd"));
				pdsVO.setCnt(rs.getInt("cnt"));
				pdsVO.setRdate(rs.getString("rdate"));
				pdsVO.setUrl(rs.getString("url"));
				pdsVO.setFile1(rs.getString("file1"));
				pdsVO.setSize1(rs.getLong("size1"));
				
				list.add(pdsVO);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con,  pstmt, rs);
		}
		return list;
	}
	/**
	 * 패스워드 검사
	 * @param pdsno 글 번호
	 * @param passwd 패스워드
	 * return 갯수
	 */
	public int passwordCheck(int pdsno, String passwd) {
		int count = 0;	//레코드 수
		
		try {
			con = dbopen.getConnection();
			
			sql = new StringBuffer();
			sql.append("select count(*) as cnt from pds3");
			sql.append(" where pdsno=? and passwd=?");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();	//select
			
			if(rs.next()==true) {
				count = rs.getInt("cnt");
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con, pstmt, rs);
		}
		return count;
	}
	public int updateFile(PdsVO pdsVO)	{
		int count = 0;	//처리된 레코드 갯수
		
		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			sql.append("UPDATE pds3");
			sql.append(" SET file1=?, size1=?");
			sql.append(" where pdsno=?");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, pdsVO.getFile1());
			pstmt.setLong(2, pdsVO.getSize1());
			pstmt.setInt(3, pdsVO.getPdsno());
		
			count = pstmt.executeUpdate();	//실행, insert 갯수 리턴
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con, pstmt);	//메모리 해제
		}
		return count;
		}
	/**
	 * 등록된 내용을 변경합니다.
	 * param vo 변경할 데이터 객체
	 * return 변경된 레코드 수
	 */
	public int update(PdsVO pdsVO)	{
		
		int count = 0;	//처리된 레코드 갯수
		
		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			sql.append("update pds3");
			sql.append(" set rname=?, email=?, title=?, content=?, url=?");
			sql.append(" where pdsno=?");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, pdsVO.getRname());
			pstmt.setString(2, pdsVO.getEmail());
			pstmt.setString(3, pdsVO.getTitle());
			pstmt.setString(4, pdsVO.getContent());
			pstmt.setString(5, pdsVO.getUrl());
			pstmt.setInt(6, pdsVO.getPdsno());
			
			
			count = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con, pstmt);
		}
		return count;
		}
public int delete(int pdsno)	{
		
		int count = 0;	//처리된 레코드 갯수
		
		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			sql.append("delete from pds3");
			sql.append(" where pdsno = ?");
			
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
				
			count = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con, pstmt);
		}
		return count;
		}
}