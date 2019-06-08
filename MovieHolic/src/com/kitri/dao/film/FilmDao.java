package com.kitri.dao.film;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.kitri.dto.FilmDto;
import com.kitri.util.DBClose;
import com.kitri.util.DBConnection;

public class FilmDao {

	// [싱글톤 패턴 객체]
	private static FilmDao filmDao;
	static {
		filmDao = new FilmDao();
	}
	private FilmDao() {}
	public static FilmDao getFilmDao() {
		return filmDao;
	}
	
	// ------------------------------------------------------- [ index.jsp ] -------------------------------------------------------
	
	// 1
	// <장르별 추천 영화 10개 select> 메소드
	// 네이버 별점순
	public List<FilmDto> selectFilmsByCategory(String category) {
		
		List<FilmDto> list = new ArrayList<FilmDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBConnection.makeConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select movieName, movieCodeYoung, movieCodeNaver, movieImage, category, prdtYear, openYear, starPointNaver \n");
			sql.append("from mh_films \n");
			sql.append("where category like '%'||?||'%' \n");
			sql.append("and rownum < 11 \n");
			sql.append("order by starpointnaver desc");
			
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, category);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				FilmDto film = new FilmDto();
				film.setMovieNm(rs.getString("movieName"));
				film.setMovieCdYoung(rs.getString("movieCodeYoung"));
				film.setMovieCdNaver(rs.getString("movieCodeNaver"));
				film.setMovieImage(rs.getString("movieImage"));
				film.setCategory(rs.getString("category"));
				film.setPrdtYear(rs.getString("prdtYear"));
				film.setOpenYear(rs.getString("openYear"));
				film.setStarPointNaver(rs.getString("starPointNaver"));
				
				list.add(film);
				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		
		return list;
		
	}
	
	
	
	
	// ------------------------------------------------------- [ moviefilm.jsp ] -------------------------------------------------------
	
	// 2
	// <주간 인기 영화 목록 select> 메소드
	//  최근 일주일간 리뷰 개수 순 10개
	public List<FilmDto> selectFilmListByReviewCount() {

		List<FilmDto> list = new ArrayList<FilmDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBConnection.makeConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select distinct mboard.mname, best.mcodeyoung \n");
			sql.append("from (select TO_CHAR(moviename) mname, TO_CHAR(moviecodeyoung) mcodeyoung \n");
			sql.append("		from mh_board) mboard , \n");
			sql.append(" 		(select TO_CHAR(moviecodeyoung) mcodeyoung, count(*) mreviewcnt \n");
			sql.append("		 from mh_board \n");
			sql.append(" 		 where boardcode = 1 \n");
			sql.append("		 and postdate between (sysdate - 7) and sysdate \n");
			sql.append("		 and rownum < 11 \n");
			sql.append("		 group by TO_CHAR(moviecodeyoung) \n");
			sql.append("		 order by count(*) desc) best \n");
			sql.append("where mboard.mcodeyoung = best.mcodeyoung");
			      
			pstmt = conn.prepareStatement(sql.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				FilmDto film = new FilmDto();
				
				film.setMovieNm(rs.getString(1));				// 영화명
				film.setMovieCdYoung(rs.getString(2));		// 영화코드(영진원)
				
				list.add(film);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		
		return list;
	}
	
	// 3
	// <장르별 영화 목록 select> 메소드
	//  개봉연도 최신순 & 네이버 별점순
	public List<FilmDto> selectFilmListByCategory(String category, int startRow, int endRow) {
		
		System.out.println("FilmDao : 파라미터로 보내 온 장르는 " + category);

		List<FilmDto> list = new ArrayList<FilmDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBConnection.makeConnection();
			
			StringBuffer sql = new StringBuffer();
			
			sql.append("select * \n");
			sql.append("from (select rownum r, f.movieName, f.movieCodeYoung, f.movieCodeNaver, f.movieImage, f.category, f.prdtYear, f.openYear, f.starPointNaver \n");
			sql.append("	  from (select movieName, movieCodeYoung, movieCodeNaver, movieImage, category, prdtYear, openYear, starPointNaver \n");
			sql.append("	   		from mh_films \n");
			sql.append("			where category like '%'||?||'%' \n");
			sql.append("			order by openYear desc, starPointNaver desc) f \n");
			sql.append("	  order by rownum) \n");
			sql.append("where r between ? and ?");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			// 장르 = 전체
			if(category == null) {
				pstmt.setString(1, "");
			} else if("null".equals(category)){
				// 장르 = 전체인데, 페이지 이동하는 경우
				pstmt.setString(1, "");
			} else {
				// 장르 = 선택 장르
				pstmt.setString(1, category);
			}
			
			// 페이지 범위
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				FilmDto film = new FilmDto();
				
				film.setMovieNm(rs.getString("movieName"));
				film.setMovieCdYoung(rs.getString("movieCodeYoung"));
				film.setMovieCdNaver(rs.getString("movieCodeNaver"));
				film.setMovieImage(rs.getString("movieImage"));
				film.setCategory(rs.getString("category"));
				film.setPrdtYear(rs.getString("prdtYear"));
				film.setOpenYear(rs.getString("openYear"));
				film.setStarPointNaver(rs.getString("starPointNaver"));
				
				list.add(film);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		
		return list;
		
	}
	
	// 4
	// <검색 결과 영화 목록 select> 메소드
	// 개봉연도 최신순 & 네이버 별점순
	public List<FilmDto> selectBySrchKey(String srchKey, int startRow, int endRow) {
 
		List<FilmDto> list = new ArrayList<FilmDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBConnection.makeConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select * \n");
			sql.append("from (select rownum r, f.movieName, f.movieCodeYoung, f.movieCodeNaver, f.movieImage, f.category, f.prdtYear, f.openYear, f.starPointNaver \n");
			sql.append("	  from (select movieName, movieCodeYoung, movieCodeNaver, movieImage, category, prdtYear, openYear, starPointNaver \n");
			sql.append("			from mh_films \n");
			sql.append("			where movieName like '%'||?||'%' \n");
			sql.append("			order by openYear desc, starPointNaver desc) f \n");
			sql.append("	  order by rownum) \n");
			sql.append("where r between ? and ?");
			
			pstmt = conn.prepareStatement(sql.toString());
			// 검색어 설정
			pstmt.setString(1, srchKey);
			// 페이지 범위
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				FilmDto film = new FilmDto();
				
				film.setMovieNm(rs.getString("movieName"));
				film.setMovieCdYoung(rs.getString("movieCodeYoung"));
				film.setMovieCdNaver(rs.getString("movieCodeNaver"));
				film.setMovieImage(rs.getString("movieImage"));
				film.setCategory(rs.getString("category"));
				film.setPrdtYear(rs.getString("prdtYear"));
				film.setOpenYear(rs.getString("openYear"));
				film.setStarPointNaver(rs.getString("starPointNaver"));
				
				list.add(film);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		
		
		return list;
		
	}
	
	// 5
	// <장르별 영화 목록 개수 select> 메소드
	// 개봉연도 최신순 & 네이버 별점순
	public int selectFilmCountByCategory(String category) {

		int cnt = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBConnection.makeConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select count(*) \n");
			sql.append("from mh_films \n");
			sql.append("where category like '%'||?||'%' \n");
			sql.append("order by openYear desc, starPointNaver desc");
			
			pstmt = conn.prepareStatement(sql.toString());
			
			// 장르 = 전체
			if(category == null) {
					pstmt.setString(1, "");
			}else {
				// 장르 = 선택 장르
				pstmt.setString(1, category);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
								
				cnt = rs.getInt(1);
				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		
		
		return cnt;
	}
	
	// 6
	// <검색한 영화 목록 개수 select> 메소드
	// 개봉연도 최신순 & 네이버 별점순
	public int selectFilmCountBySrchKey(String srchKey) {

		int cnt = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBConnection.makeConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select count(*) \n");
			sql.append("from mh_films \n");
			sql.append("where movieName like '%'||?||'%' \n");
			sql.append("order by openYear desc, starPointNaver desc");
			
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, srchKey);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
								
				cnt = rs.getInt(1);
				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		
		
		return cnt;
		
	}
	
	
	
	// ------------------------------------------------------- [ moviedetail.jsp ] -------------------------------------------------------
	
	
}
