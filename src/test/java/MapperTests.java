import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.mapper.BoardMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/*.xml")

@Log4j2
public class MapperTests {

    @Setter(onMethod_= @Autowired)
    BoardMapper mapper;

    @Test
    public void testMapper(){
        log.info("mapper: {}", mapper);
    } //testMapper
} //end class
