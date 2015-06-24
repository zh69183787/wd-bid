package com.wonders.stpt.bid.security;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.LinkedList;

import javax.annotation.PostConstruct;

import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created with IntelliJ IDEA.
 * User: hhb
 * Date: 14-4-8
 * Time: 下午3:09
 * To change this template use File | Settings | File Templates.
 */
public class SecurityRequestMapFactoryBean extends
        LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>> {

//    @Autowired
//    private IAuthorityService authorityService;

    @PostConstruct
    public void loadSecurityInfos() {
//        HashMap param = new HashMap();
//        param.put("statusCode", "1");
//        List<Authority> authorities = authorityService.selectAllList(param);
//        for (final Authority authority : authorities) {
//            AntPathRequestMatcher antPathRequestMatcher = new AntPathRequestMatcher(authority.getResourceUrl(),authority.getMethod());
//            ArrayList<ConfigAttribute> configAttributes = new ArrayList<ConfigAttribute>();
//            configAttributes.add(new ConfigAttribute() {
//                public String getAttribute() {
//                    return authority.getAuthorityName();
//                }
//            });
//            this.put(antPathRequestMatcher, configAttributes);
//        }
//        addDefaultInfo("/home","ROLE_ANONYMOUS,ROLE_USER");
//        addDefaultInfo("/authenticationError","ROLE_ANONYMOUS,ROLE_USER");
//        addDefaultInfo("/**","ROLE_USER");
    }

    private void addDefaultInfo(String pattern,String authority) {
        AntPathRequestMatcher antPathRequestMatcher = new AntPathRequestMatcher(pattern,RequestMethod.GET.toString());
        Collection<ConfigAttribute> configAttributes = new LinkedList<ConfigAttribute>();
        String[] authorities = authority.split(",");
        for (final String auth : authorities) {
            configAttributes.add(new ConfigAttribute() {
                public String getAttribute() {
                    return auth;
                }
            });
        }
        this.put(antPathRequestMatcher, configAttributes);
    }


}
