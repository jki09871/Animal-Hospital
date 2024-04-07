package com.review.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.inject.Inject;
import javax.sql.DataSource;
import java.sql.Connection;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/*.xml" })
public class SqlConnection {

    @Inject
    private DataSource datas;

    @Test
    public void testConnection() throws Exception {
        try (Connection con = datas.getConnection()) {
            System.out.println(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
