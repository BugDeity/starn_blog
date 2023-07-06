<template>
    <div class="app-container">
        <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
                <el-button v-if="canDelBatch" :disabled="!multipleSelection.length" type="danger" icon="el-icon-delete"
                    size="small" @click="handleDeleteBatch">批量删除
                </el-button>
            </el-col>
        </el-row>

        <div style="margin-top: 5px">
            <el-table border :data="tableData" style="width: 100%" @selection-change="handleSelectionChange">
                <el-table-column type="selection" align="center" />
                <el-table-column prop="nickname" align="center" width="150" label="用户昵称" />
                <el-table-column prop="categoryName" align="center" width="200" label="分类名称" />
                <el-table-column prop="content" align="center" label="内容" />
                <el-table-column prop="createTime" width="200" align="center" label="评论时间" />

                <el-table-column align="center" label="操作" width="200" class-name="small-padding fixed-width">
                    <template slot-scope="scope">
                        <el-button v-if="canDelBatch" size="mini" type="danger"
                            @click="handleDeleteBatch(scope.row.id)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>

        <!--分页区域-->
        <div class="pagination-container" style="float: right;margin-bottom: 1.25rem;margin-top: 1.25rem;">
            <el-pagination background @size-change="handleSizeChange" @current-change="handleCurrentChange"
                :current-page="params.pageNo" :page-size="params.pageSize" :page-sizes="[10, 20, 30]"
                layout="total, sizes,prev, pager, next,jumper" :total="total">
            </el-pagination>
        </div>
    </div>
</template>
<script>
import { fetchNote, deleteNote } from '@/api/note'
import { parseTime } from '@/utils'
import { mapGetters } from "vuex";
import { hasAuth } from "@/utils/auth";

export default {
    data() {
        return {
            tableData: [],
            multipleSelection: [],
            // 加载层信息
            loading: [],
            total: 0,
            showSearch: true,
            params: {
                pageNo: 1,
                pageSize: 10
            }
        }
    },
    created: function () {

        this.fetchNote()
    },
    computed: {
        ...mapGetters([
            'pres'
        ]),
        canDelBatch: function () {
            return hasAuth(this.pres, '/system/note/delete')
        }
    },
    methods: {
        fetchNote: function () {
            this.openLoading();
            fetchNote(this.params).then(res => {
                this.tableData = res.data.records
                this.total = res.data.total
                this.loading.close();
            }).catch(err => {
                console.log(err)
            })
        },
        handleDeleteBatch: function (id) {
            this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                let ids = []
                if (id != null) {
                    ids.push(id)
                } else {
                    this.multipleSelection.forEach(item => {
                        ids.push(item.id)
                    })
                }
                deleteNote(ids).then(res => {
                    this.$message.success("OK")
                    this.fetchNote()
                }).catch(err => {
                    console.error(err)
                })
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '取消删除'
                })
            })
        },
        // 打开加载层
        openLoading: function () {
            this.loading = this.$loading({
                lock: true,
                text: "正在加载中~",
                spinner: "el-icon-loading",
                background: "rgba(0, 0, 0, 0.7)"
            });
        },
        handleSelectionChange: function (val) {
            this.multipleSelection = val;
        },
        handleSizeChange: function (val) {
            this.params.pageSize = val
            this.fetchNote()
        },
        handleCurrentChange: function (val) {
            this.params.pageNo = val
            this.fetchNote()
        },
    }
}
</script>
