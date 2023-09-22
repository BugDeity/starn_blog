import request from "@/utils/request";

//留言管理
export function getSayList(params) {
  return request({
    url: '/system/say/list',
    method: 'get',
    params: params
  })
}
export function insertSay(data) {
  return request({
    url: '/system/say/',
    method: 'post',
    data
  })
}
export function deleteSay(data) {
  return request({
    url: '/system/say/delete',
    method: 'delete',
    data
  })
}
