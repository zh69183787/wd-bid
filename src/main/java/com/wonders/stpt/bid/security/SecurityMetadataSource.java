package com.wonders.stpt.bid.security;

import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import javax.annotation.PostConstruct;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: hhb
 * Date: 14-4-21
 * Time: 下午3:27
 * To change this template use File | Settings | File Templates.
 */
public class SecurityMetadataSource implements FilterInvocationSecurityMetadataSource {

//    @Autowired
//    private IAuthorityService authorityService;

    private HashMap<AntPathRequestMatcher, Collection<ConfigAttribute>> resourceMap = null;

    /**
     * 自定义方法，这个类放入到Spring容器后，
     * 指定init为初始化方法，从数据库中读取资源
     * TODO(这里用一句话描述这个方法的作用).
     */
    @PostConstruct
    public void init() {
        loadResourceDefine();
    }

    /**
     * TODO(程序启动的时候就加载所有资源信息).
     */
    private void loadResourceDefine() {
//        HashMap param = new HashMap();
//        param.put("statusCode", "1");
//        List<Authority> authorities = authorityService.selectAllList(param);
//        resourceMap = new HashMap<AntPathRequestMatcher, Collection<ConfigAttribute>>();
//
//
//
//        for (final Authority authority : authorities) {
//            AntPathRequestMatcher antPathRequestMatcher = new AntPathRequestMatcher(authority.getResourceUrl());
//            ArrayList<ConfigAttribute> configAttributes = new ArrayList<ConfigAttribute>();
//            configAttributes.add(new ConfigAttribute() {
//                public String getAttribute() {
//                    return authority.getAuthorityName();
//                }
//            });
//            resourceMap.put(antPathRequestMatcher, configAttributes);
//        }
//
//        addDefaultInfo("/home","ROLE_ANONYMOUS");
//        addDefaultInfo("/authenticationError","ROLE_ANONYMOUS");
//
//        addDefaultInfo("/*","ROLE_USER");

    }
    private void addDefaultInfo(String pattern,final String authority) {
        AntPathRequestMatcher antPathRequestMatcher = new AntPathRequestMatcher(pattern);
        Collection<ConfigAttribute> configAttributes = new LinkedList<ConfigAttribute>();
        configAttributes.add(new ConfigAttribute() {
            public String getAttribute() {
                return authority;
            }
        });
        resourceMap.put(antPathRequestMatcher, configAttributes);
    }


//    /**
//     * TODO(自定义方法，将List<Role>集合转换为框架需要的Collection<ConfigAttribute>集合).
//     *
//     * @param roles 角色集合
//     * @return list 封装好的Collection集合
//     */
//    private Collection<ConfigAttribute> listToCollection(List<RoleEntity> roles) {
//        List<ConfigAttribute> list = new ArrayList<ConfigAttribute>();
//
//        for (RoleEntity role : roles) {
//            list.add(new SecurityConfig(role.getRoleName()));
//
//        }
//        return list;
//    }

    /*
     * <p>Title: getAllConfigAttributes</p>
     * <p>Description: </p>
     * @return
     * @see org.springframework.security.access.SecurityMetadataSource#getAllConfigAttributes()
     */
    @Override
    public Collection<ConfigAttribute> getAllConfigAttributes() {
        return null;
    }

    /*
     * <p>Title: getAttributes</p>
     * <p>Description: </p>
     * @param arg0
     * @return
     * @throws IllegalArgumentException
     * @see org.springframework.security.access.SecurityMetadataSource#getAttributes(java.lang.Object)
     */
    @Override
    public Collection<ConfigAttribute> getAttributes(Object object)
            throws IllegalArgumentException {
        //object 是一个URL ,为用户请求URL
        String url = ((FilterInvocation) object).getRequestUrl();
        if ("/".equals(url)) {
            return null;
        }
        int firstQuestionMarkIndex = url.indexOf(".");
        //判断请求是否带有参数 如果有参数就去掉后面的后缀和参数(/index.do  --> /index)
        if (firstQuestionMarkIndex != -1) {
            url = url.substring(0, firstQuestionMarkIndex);
        }

        AntPathRequestMatcher requestMatcher = new AntPathRequestMatcher(url);
        return resourceMap.get(requestMatcher);
    }


    /*
     * <p>Title: supports</p>
     * <p>Description: </p>
     * @param arg0
     * @return
     * @see org.springframework.security.access.SecurityMetadataSource#supports(java.lang.Class)
     */
    @Override
    public boolean supports(Class<?> arg0) {
        // TODO Auto-generated method stub
        return true;
    }
}
