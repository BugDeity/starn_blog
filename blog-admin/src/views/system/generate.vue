<template>
    <div class="app-container">

        <div style="margin-top: 5px">
            <el-table border :data="tableData" style="width: 100%" @selection-change="handleSelectionChange">
                <el-table-column align="center" type="selection"></el-table-column>
                <el-table-column label="表名称" align="center">
                    <template slot-scope="scope">
                        <span>{{ scope.row.name }}</span>
                    </template>
                </el-table-column>
                <el-table-column label="表描述" align="center">
                    <template slot-scope="scope">
                        <span>{{ scope.row.comment }}</span>
                    </template>
                </el-table-column>
                <el-table-column label="创建时间" align="center">
                    <template slot-scope="scope">
                        <span>{{ scope.row.createTime }}</span>
                    </template>
                </el-table-column>
                <el-table-column label="修改时间" align="center">
                    <template slot-scope="scope">
                        <span>{{ scope.row.updateTime }}</span>
                    </template>
                </el-table-column>

                <el-table-column label="操作" align="center">
                    <template slot-scope="scope">
                        <el-button @click="handlePreview(scope.row.name)" type="text">
                            <i class="el-icon-view"></i> 预览
                        </el-button>
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

        <!-- 添加或修改对话框 -->
        <el-dialog center :title="preview.title" :visible.sync="preview.open" top="5vh" width="80%">
            <el-tabs v-model="preview.activeName">
                <el-tab-pane v-for="(value, key) in  preview.data "
                    :label="key.substring(key.lastIndexOf('/') + 1, key.indexOf('.vm'))"
                    :name="key.substring(key.lastIndexOf('/') + 1, key.indexOf('.vm'))" :key="key">
                    <el-link :underline="false" icon="el-icon-document-copy" @click="clipboardSuccess(value)"
                        style="float:right">复制</el-link>
                    <pre><code class="hljs" v-html="highlightedCode(value, key)"></code></pre>
                </el-tab-pane>
            </el-tabs>
        </el-dialog>
    </div>
</template>

<script>
import { preview, getTableList } from "@/api/generate"
import { mapGetters } from "vuex";
import { hasAuth } from "@/utils/auth";

import hljs from 'highlight.js';
import 'highlight.js/styles/github.css' //样式
hljs.registerLanguage("java", require("highlight.js/lib/languages/java"));
hljs.registerLanguage("xml", require("highlight.js/lib/languages/xml"));
hljs.registerLanguage("html", require("highlight.js/lib/languages/xml"));
hljs.registerLanguage("vue", require("highlight.js/lib/languages/xml"));
hljs.registerLanguage("javascript", require("highlight.js/lib/languages/javascript"));
hljs.registerLanguage("sql", require("highlight.js/lib/languages/sql"));
export default {
    data() {
        return {
            multipleSelection: [], //多选，用于批量删除
            tableData: [],
            params: {
                pageNo: 1,
                pageSize: 10,
            },
            total: 0, //总数量
            showSearch: true,
            form: {},
            rules: {
                name: [
                    { required: true, message: '名称不能为空', trigger: 'blur' },
                    { min: 1, max: 20, message: '长度在1到10个字符' },
                ],
            },
            // 预览参数
            preview: {
                open: false,
                title: "代码预览",
                data: {},
                activeName: "domain.java"
            }
        };
    },
    computed: {
        ...mapGetters([
            'pres'
        ]),

    },
    created() {
        this.getTableList();
    },
    methods: {
        /** 复制代码成功 */
        clipboardSuccess(value) {
            const clipboard = new this.Clipboard('.el-link', {
                text: () => value
            })
            clipboard.on('success', () => {
                this.$message.success('复制成功！')
                clipboard.destroy()
            })
            clipboard.on('error', () => {
                this.$message.error('该浏览器不支持自动复制,请手动复制！')
                clipboard.destroy()
            })
        },
        handlePreview: function (name) {
            preview(name).then(response => {
                this.preview.data = response.data;
                this.preview.open = true
                this.preview.activeName = "domain.java";
            }).catch(err => {
                console.log(err)
            });
        },
        /** 高亮显示 */
        highlightedCode(code, key) {
            const vmName = key.substring(key.lastIndexOf("/") + 1, key.indexOf(".vm"));
            var language = vmName.substring(vmName.indexOf(".") + 1, vmName.length);
            const result = hljs.highlight(language, code || "", true);
            return result.value || '&nbsp;';
        },
        getTableList: function () {
            getTableList(this.params).then(response => {
                this.tableData = response.data.records;
                this.total = response.data.total;
            }).catch(err => {
                console.log(err)
            });
        },

        resetQuery: function () {
            this.params.name = null
            this.getTableList()
        },
        handleFind: function () {
            this.params.pageNo = 1
            this.getTableList();
        },

        handleDeleteBatch: function (row) {
            if (row) {
                this.multipleSelection.push(row);
            }
            if (this.multipleSelection.length <= 0) {
                this.$message.error("请先选中需要删除的内容!")
                return;
            }
            this.$confirm("此操作将把选中字典类型删除, 是否继续?", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning"
            })
                .then(() => {
                    let ids = []
                    this.multipleSelection.forEach(item => {
                        ids.push(item.id)
                    })
                    deleteTalk(ids).then(response => {
                        this.multipleSelection = []
                        this.$message.success(response.message)
                        this.getTableList();
                    }).catch(err => {
                        console.error(err)
                    });
                }).catch(() => {
                    this.$message.info("已取消删除")
                });
        },
        handleCurrentChange: function (val) {
            this.params.pageNo = val;
            this.getTableList();
        },
        handleSizeChange: function (val) {
            this.params.pageSize = val
            this.getTableList()
        },
        // 改变多选
        handleSelectionChange: function (val) {
            this.multipleSelection = val;
        },
    }
};
</script>
